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
    let pointID: UUID
    var name: String
    var address: DeliveryAddress
    //var location: CLLocationCoordinate2D
    var capacity: Int
    var operatingHours: String
    var ratings: [Double]
    var associatedReceiver: ReceivingUser
    
    var averageRating: Double {
            return ratings.isEmpty ? 0.0 : ratings.reduce(0, +) / Double(ratings.count)
    }
    
    init(name: String, address: DeliveryAddress, capacity: Int, operatingHours: String, associatedReceiver: ReceivingUser) {
           self.pointID = UUID()
           self.name = name
           self.address = address
          // self.location = location
           self.capacity = capacity
           self.operatingHours = operatingHours
           self.ratings = []
           self.associatedReceiver = associatedReceiver
       }
    
    func addRating(_ rating: Double) {
            ratings.append(rating)
    }
}


