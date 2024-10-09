//
//  CloudKitMANAGER.swift
//  FinalChallenge
//
//  Created by Pamella Alvarenga on 08/10/24.
//

//import CloudKit
//
//class CloudKitManager {
//    
//    static let shared = CloudKitManager() //Singleton que garntirá que, em qualquer lugar da aplicaçao, será usada a mesma instância
//    
//    private let container: CKContainer
//    private let privateDatabase: CKDatabase
//    private let publicDatabase: CKDatabase
//    
//    private init() { //O inicializador privado força o uso do singleton
//        
//        container = CKContainer.default()
//        publicDatabase = container.publicCloudDatabase
//        privateDatabase = container.privateCloudDatabase
//
//    }
//    
//    func savePublicRecord(_ record: CKRecord, completion: @escaping (Result<Void, Error>) -> Void) {
//            publicDatabase.save(record) { _, error in
//                if let error = error {
//                    completion(.failure(error))
//                } else {
//                    completion(.success(()))
//                }
//            }
//        }
//    
//    func savePrivateRecord(_ record: CKRecord, completion: @escaping (Result<Void, Error>) -> Void) {
//            privateDatabase.save(record) { _, error in
//                if let error = error {
//                    completion(.failure(error))
//                } else {
//                    completion(.success(()))
//                }
//            }
//        }
//    
//    func fetchPublicRecords(recordType: String, completion: @escaping (Result<[CKRecord], Error>) -> Void) {
//            let query = CKQuery(recordType: recordType, predicate: NSPredicate(value: true))
//            publicDatabase.perform(query, inZoneWith: nil) { records, error in
//                if let error = error {
//                    completion(.failure(error))
//                } else {
//                    completion(.success(records ?? []))
//                }
//            }
//        }
//    
//    func fetchPrivateRecords(recordType: String, completion: @escaping (Result<[CKRecord], Error>) -> Void) {
//            let query = CKQuery(recordType: recordType, predicate: NSPredicate(value: true))
//            privateDatabase.perform(query, inZoneWith: nil) { records, error in
//                if let error = error {
//                    completion(.failure(error))
//                } else {
//                    completion(.success(records ?? []))
//                }
//            }
//        }
//}
