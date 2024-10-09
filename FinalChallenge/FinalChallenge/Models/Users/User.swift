//
//  User.swift
//  FinalChallenge
//
//  Created by Pamella Alvarenga on 08/10/24.
//

import SwiftData

protocol UserProtocol {
    var id: String { get }
       var CPF: String { get }
       var name: String { get }
       var adress: DeliveryAddress { get }
       var phone: String { get }
       var email: String { get }
       var identifyVerified: Bool { get set }
       
}


func saveUserLocally(user: UserProtocol, context: ModelContext) {
    if let userModel = user as? ReceivingUser {
            context.insert(userModel)
        } else if let userModel = user as? BuyingUser {
            context.insert(userModel)
        }
    do {
        try context.save()
        print("User saved locally")
    } catch {
        print("Error saving user locally: \(error.localizedDescription)")
    }
    
}
