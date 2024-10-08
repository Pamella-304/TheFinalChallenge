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
class CollectionPoint {
    
    @Attribute(.unique)
    let pointID: UUID
    var address: DeliveryAddress
    var location: CLLocationCoordinate2D
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
    
    init(address: DeliveryAddress, location: CLLocationCoordinate2D ,capacity: Int, operatingHours: String, associatedReceiver: ReceivingUser) {
           self.pointID = UUID()
           self.address = address
           self.location = location
           self.capacity = capacity
           self.operatingHours = operatingHours
           self.ratings = []
           self.associatedReceiver = associatedReceiver
       }
    
    func addRating(_ rating: Double) {
            ratings.append(rating)
    }
}


