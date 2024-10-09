//
//  ReceivingUser.swift
//  FinalChallenge
//
//  Created by Pamella Alvarenga on 08/10/24.
//


import SwiftData
import CoreLocation
import CloudKit

@Model
class ReceivingUser: UserProtocol, Codable {
   
    @Attribute(.unique)
    var id = UUID().uuidString
    @Attribute(.unique)
    var CPF: String
    var name: String
    var adress: DeliveryAddress
    var collectionPoint: CollectionPoint
    var phone: String
    var email: String
    var latitude: Double
    var longitude: Double
    var identifyVerified: Bool
    var availability: String
    var abcenses: [String]
    var mediumRate: Double
    
   // @Relationship(inverse: \Review.receiver)
    var reviewsReceived: [Review]
    var comments: [String]
    var storageCapacity: Int
    var packagesTipe: [String]
    var storageConditions: String
    var currentOrders: [Order] = []
    var documents: [String]
    var recievedPackagesHistory: [String]
    var currentStatus: String
    
    enum CodingKeys: String, CodingKey {
            case id, CPF, name, adress, collectionPoint, phone, email, latitude, longitude, identifyVerified, availability, abcenses, mediumRate, comments, storageCapacity, packagesTipe, storageConditions, currentOrders, documents, recievedPackagesHistory, currentStatus, reviewsReceived
        }


    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
                self.id = try container.decode(String.self, forKey: .id)
                self.CPF = try container.decode(String.self, forKey: .CPF)
                self.name = try container.decode(String.self, forKey: .name)
                self.adress = try container.decode(DeliveryAddress.self, forKey: .adress)
                self.collectionPoint = try container.decode(CollectionPoint.self, forKey: .collectionPoint)
                self.phone = try container.decode(String.self, forKey: .phone)
                self.email = try container.decode(String.self, forKey: .email)
                self.latitude = try container.decode(Double.self, forKey: .latitude)
                self.longitude = try container.decode(Double.self, forKey: .longitude)
                self.identifyVerified = try container.decode(Bool.self, forKey: .identifyVerified)
                self.availability = try container.decode(String.self, forKey: .availability)
                self.abcenses = try container.decode([String].self, forKey: .abcenses)
                self.mediumRate = try container.decode(Double.self, forKey: .mediumRate)
                self.reviewsReceived = try container.decode([Review].self, forKey: .reviewsReceived)
                self.comments = try container.decode([String].self, forKey: .comments)
                self.storageCapacity = try container.decode(Int.self, forKey: .storageCapacity)
                self.packagesTipe = try container.decode([String].self, forKey: .packagesTipe)
                self.storageConditions = try container.decode(String.self, forKey: .storageConditions)
                self.currentOrders = try container.decode([Order].self, forKey: .currentOrders)
                self.documents = try container.decode([String].self, forKey: .documents)
                self.recievedPackagesHistory = try container.decode([String].self, forKey: .recievedPackagesHistory)
                self.currentStatus = try container.decode(String.self, forKey: .currentStatus)
            }
    
    init(CPF: String, name: String, adress: DeliveryAddress, phone: String, email: String, latitude: Double, longitude: Double, identifyVerified: Bool, availability: String, abcenses: [String], mediumRate: Double, comments: [String], storageCapacity: Int, packagesTipe: [String], storageConditions: String, currentStatus: String, documents: [String], recievedPackagesHistory: [String], collectionPoint: CollectionPoint) {
        
        self.CPF = CPF
        self.name = name
        self.adress = adress
        self.collectionPoint = collectionPoint
        self.phone = phone
        self.email = email
        self.latitude = latitude
        self.longitude = longitude
        self.identifyVerified = false
        self.availability = availability
        self.abcenses = abcenses
        self.mediumRate = mediumRate
        self.comments = comments
        self.storageCapacity = storageCapacity
        self.packagesTipe = packagesTipe
        self.storageConditions = storageConditions
        self.documents = documents
        self.recievedPackagesHistory = recievedPackagesHistory
        self.currentStatus = currentStatus
        self.reviewsReceived = []
    }
    
}


extension ReceivingUser {
    
    func deleteUser(_ user: ReceivingUser, context: ModelContext) {
        if currentOrders.count > 0 {
            for order in user.currentOrders {
                context.delete(order)
            }
        }
        context.delete(user)

        try? context.save()
    }
    
    func location() -> CLLocation {
        return CLLocation(latitude: latitude, longitude: longitude)
    }
            
    func encode(to encoder: Encoder) throws {
                    var container = encoder.container(keyedBy: CodingKeys.self)
                    try container.encode(id, forKey: .id)
                    try container.encode(CPF, forKey: .CPF)
                    try container.encode(name, forKey: .name)
                    try container.encode(adress, forKey: .adress)
                    try container.encode(collectionPoint, forKey: .collectionPoint)
                    try container.encode(phone, forKey: .phone)
                    try container.encode(email, forKey: .email)
                    try container.encode(latitude, forKey: .latitude)
                    try container.encode(longitude, forKey: .longitude)
                    try container.encode(identifyVerified, forKey: .identifyVerified)
                    try container.encode(availability, forKey: .availability)
                    try container.encode(abcenses, forKey: .abcenses)
                    try container.encode(mediumRate, forKey: .mediumRate)
                    try container.encode(reviewsReceived, forKey: .reviewsReceived)
                    try container.encode(comments, forKey: .comments)
                    try container.encode(storageCapacity, forKey: .storageCapacity)
                    try container.encode(packagesTipe, forKey: .packagesTipe)
                    try container.encode(storageConditions, forKey: .storageConditions)
                    try container.encode(currentOrders, forKey: .currentOrders)
                    try container.encode(documents, forKey: .documents)
                    try container.encode(recievedPackagesHistory, forKey: .recievedPackagesHistory)
                    try container.encode(currentStatus, forKey: .currentStatus)
        }
}



