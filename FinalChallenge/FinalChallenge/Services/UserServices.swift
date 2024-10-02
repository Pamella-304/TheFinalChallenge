//
//  UserServices.swift
//  FinalChallenge
//
//  Created by Pamella Alvarenga on 01/10/24.
//

import SwiftData
import CloudKit

class UserService: ObservableObject {
    
    @Environment(\.modelContext) var modelContext
    
    private let privateDatabase: CKDatabase
    
    init(context: ModelContext) {
        self.modelContext = context
        self.privateDatabase = CKContainer(identifier: "iCloud.AppleAcademy.FinalChallenge").privateCloudDatabase
    }
    
    
//    func saveUserLocally(user: User, completion: @escaping (Result<Void, Error>) -> Void) {
//        modelContext.insert(user)
//        do{
//            try modelContext.save()
//            print("User saved locally")
//        } catch {
//            print("Error saving user locally: \(error.localizedDescription)")
//            completion(.failure(error))
//        }
//    }
//    
    func saveUserToCloudKit(user: User, completion: @escaping (Result<CKRecord, Error>) -> Void) {
        
        let userRecord = CKRecord(recordType: "User")
        
        // Mapear os atributos comund de usuário
        userRecord["id"] = user.id as CKRecordValue
        userRecord["CPF"] = user.CPF as CKRecordValue
        userRecord["name"] = user.name as CKRecordValue
        userRecord["phone"] = user.phone as CKRecordValue
        userRecord["email"] = user.email as CKRecordValue
        
        
        // Converter CLLocation para latitude e longitude
//        userRecord["latitude"] = user.location.coordinate.latitude as CKRecordValue
//        userRecord["longitude"] = user.location.coordinate.longitude as CKRecordValue
        userRecord["identifyVerified"] = user.identifyVerified as CKRecordValue
        
        // Mapear o endereço do usuário para CloudKit
        let addressRecord = CKRecord(recordType: "DeliveryAddress")
        addressRecord["street"] = user.adress.street as CKRecordValue
        addressRecord["city"] = user.adress.city as CKRecordValue
        addressRecord["state"] = user.adress.state as CKRecordValue
        addressRecord["postalCode"] = user.adress.postalCode as CKRecordValue
        addressRecord["country"] = user.adress.country as CKRecordValue
        userRecord["adress"] = CKRecord.Reference(record: addressRecord, action: .deleteSelf)
        
        // Verificar o tipo de usuário e mapear os dados específicos
        if let receivingUser = user as? ReceivingUser {
            userRecord["availability"] = receivingUser.availability as CKRecordValue
            userRecord["abcenses"] = receivingUser.abcenses as CKRecordValue
            userRecord["mediumRate"] = receivingUser.mediumRate as CKRecordValue
            userRecord["numReviews"] = receivingUser.numReviews as CKRecordValue
            userRecord["comments"] = receivingUser.comments as CKRecordValue
            userRecord["storageCapacity"] = receivingUser.storageCapacity as CKRecordValue
            userRecord["packagesTipe"] = receivingUser.packagesTipe as CKRecordValue
            userRecord["storageConditions"] = receivingUser.storageConditions as CKRecordValue
            
            // lidando com documentos e histórico de pacotes, se necessário
            userRecord["documents"] = receivingUser.documents as CKRecordValue
            userRecord["recievedPackagesHistory"] = receivingUser.recievedPackagesHistory as CKRecordValue
            userRecord["currentStatus"] = receivingUser.currentStatus as CKRecordValue
            
        } else if let buyingUser = user as? BuyingUser {
            userRecord["preferredPickupLocation"] = buyingUser.preferredPickupLocation as CKRecordValue?
            userRecord["paymentMethod"] = buyingUser.paymentMethod as CKRecordValue?
            userRecord["notificationsEnabled"] = buyingUser.notificationsEnabled as CKRecordValue
            userRecord["loyaltyPoints"] = buyingUser.loyaltyPoints as CKRecordValue
            
            // lidando com o histórico de pedidos, avaliações e preferências salvas, se necessário
            userRecord["orderHistory"] = buyingUser.orderHistory as CKRecordValue
            userRecord["reviewsGiven"] = buyingUser.reviewsGiven as CKRecordValue
            userRecord["favoriteReceivers"] = buyingUser.favoriteReceivers as CKRecordValue?
            userRecord["currentOrders"] = buyingUser.currentOrders as CKRecordValue
        }
        
        saveRecord(record: userRecord, completion: completion)
        
    }
    
    func saveRecord(record: CKRecord, retryCount: Int = 3, completion: @escaping (Result<CKRecord, Error>) -> Void) {
        privateDatabase.save(record) { (savedRecord, error) in
            if let error = error {
                print("Erro ao salvar no CloudKit: \(error.localizedDescription)")
                
                // Verificação se é um erro temporário e se ainda há tentativas restantes
                if let ckError = error as? CKError {
                    switch ckError.code {
                    case .networkUnavailable, .networkFailure:
                        print("Erro de rede, tentando novamente...")
                        if retryCount > 0 {
                            DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
                                self.saveRecord(record: record, retryCount: retryCount - 1, completion: completion)
                            }
                            return
                        }
                    default:
                        print("Erro inesperado: \(ckError.localizedDescription)")
                    }
                }
                completion(.failure(error))
            } else if let savedRecord = savedRecord {
                completion(.success(savedRecord))
            }
        }
    }
    
    func registerUser(user: User) {
        // Salvar localmente
        saveUserLocally(user: user) { localResult in
            switch localResult {
            case .success:
                print("User saved locally successfully")
                
                // Salvar no CloudKit com tratamento de erro
                self.saveUserToCloudKit(user: user) { cloudKitResult in
                    switch cloudKitResult {
                    case .success(let record):
                        print("User saved to CloudKit with record ID: \(record.recordID)")
                    case .failure(let error):
                        print("Error saving user to CloudKit: \(error.localizedDescription)")
                    }
                }
                
            case .failure(let error):
                print("Error saving user locally: \(error.localizedDescription)")
             
            }
        }
    }
}
