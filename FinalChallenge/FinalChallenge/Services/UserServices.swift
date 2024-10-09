//
//  UserServices.swift
//  FinalChallenge
//
//  Created by Pamella Alvarenga on 01/10/24.
//

import SwiftUI
import SwiftData

class UserService {
    
   //@Environment(\.modelContext) var context
    
    func saveUserLocally(user: some PersistentModel, context: ModelContext, completion: @escaping (Result<Void, Error>) -> Void) {
            context.insert(user)
            do {
                try context.save()
                print("user saved locally")
                completion(.success(()))
            } catch {
                print("Error saving user locally: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
        
        // Função para registrar qualquer tipo de usuário
    func registerUser(user: some PersistentModel, context: ModelContext) {
            saveUserLocally(user: user, context: context) { localResult in
                switch localResult {
                case .success:
                    print("user saved locally successfully")
                case .failure(let error):
                    print("Error saving user locally: \(error.localizedDescription)")
                }
            }
        }

    
    
    
}
