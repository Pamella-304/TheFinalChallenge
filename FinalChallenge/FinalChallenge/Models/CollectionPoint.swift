//
//  CollectionPoint.swift
//  FinalChallenge
//
//  Created by Pamella Alvarenga on 27/09/24.
//

import Foundation
import CoreLocation
import SwiftData


@Model
class CollectionPoint: Codable {
    
    @Attribute(.unique)
    let pointID: UUID
    var address: DeliveryAddress
    var latitude: Double
    var longitude: Double
    var capacity: Int
    var operatingHours: String
    var ratings: [Double]
    
    @Relationship(inverse: \ReceivingUser.collectionPoint)
    var associatedReceiver: ReceivingUser
    
    @Relationship(inverse: \ReceivingUser.currentOrders)
    var currentOrders: [Order]
    
    @Relationship(inverse: \ReceivingUser.currentStatus)
    var currentStatus: Bool
    
    
    var averageRating: Double {
            return ratings.isEmpty ? 0.0 : ratings.reduce(0, +) / Double(ratings.count)
    }
    
    enum CodingKeys: String, CodingKey {
            case pointID, address, latitude, longitude, capacity, operatingHours, ratings, associatedReceiver, currentOrders, currentStatus
        }
        
        required init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.pointID = try container.decode(UUID.self, forKey: .pointID)
            self.address = try container.decode(DeliveryAddress.self, forKey: .address)
            self.latitude = try container.decode(Double.self, forKey: .latitude)
            self.longitude = try container.decode(Double.self, forKey: .longitude)
            self.capacity = try container.decode(Int.self, forKey: .capacity)
            self.operatingHours = try container.decode(String.self, forKey: .operatingHours)
            self.ratings = try container.decode([Double].self, forKey: .ratings)
            self.associatedReceiver = try container.decode(ReceivingUser.self, forKey: .associatedReceiver)
            self.currentOrders = try container.decode([Order].self, forKey: .currentOrders)
            self.currentStatus = try container.decode(Bool.self, forKey: .currentStatus)
        }
    
    init(address: DeliveryAddress, latitude: Double ,longitude: Double, capacity: Int, operatingHours: String, associatedReceiver: ReceivingUser, ratings: [Double]) {
        self.pointID = UUID()
        self.address = address
        self.latitude = latitude
        self.longitude = longitude
        self.capacity = capacity
        self.operatingHours = operatingHours
        self.ratings = []
        self.associatedReceiver = associatedReceiver
        self.currentOrders = []
        self.currentStatus = false
       }
    

  
}

extension CollectionPoint {
    
    func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(pointID, forKey: .pointID)
            try container.encode(address, forKey: .address)
            try container.encode(latitude, forKey: .latitude)
            try container.encode(longitude, forKey: .longitude)
            try container.encode(capacity, forKey: .capacity)
            try container.encode(operatingHours, forKey: .operatingHours)
            try container.encode(ratings, forKey: .ratings)
            try container.encode(associatedReceiver, forKey: .associatedReceiver)
            try container.encode(currentOrders, forKey: .currentOrders)
            try container.encode(currentStatus, forKey: .currentStatus)
        }
    
    func addRating(_ rating: Double) {
            ratings.append(rating)
    }
    
    func location() -> CLLocation {
        return CLLocation(latitude: latitude, longitude: longitude)
    }
}


