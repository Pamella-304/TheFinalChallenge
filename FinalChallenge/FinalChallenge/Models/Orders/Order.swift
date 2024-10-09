//
//  Orders.swift
//  FinalChallenge
//
//  Created by Pamella Alvarenga on 27/09/24.
//

import SwiftData
import CloudKit

//Core Data Lab

@Model
class Order: Codable {
    
    @Attribute(.unique)
    let orderID = UUID()
    var orderDate: Date
    var deliveryDate: Date?
    @Relationship(inverse: \BuyingUser.currentOrders)
    var buyer: BuyingUser
    @Relationship(inverse: \ReceivingUser.currentOrders)
    var receiver: ReceivingUser
    @Relationship(inverse: \CollectionPoint.currentOrders)
    var collectionPoint: CollectionPoint
    
    var items: [OrderItem]
    var totalAmount: Double
    var paymentMethod: String
    var status: OrderStatus
    var trackingNumber: String?
    var deliveryAddress: String // escolher um tipo mais adequado futuramente
    var latitude: Double
    var longitude: Double
    var notes: String?
    
    enum CodingKeys: String, CodingKey {
            case orderID, orderDate, deliveryDate, buyer, receiver, collectionPoint, items, totalAmount, paymentMethod, status, trackingNumber, deliveryAddress, latitude, longitude, notes
        }
    
    required init(from decoder: Decoder) throws {
        
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            self.orderID = try container.decode(UUID.self, forKey: .orderID)
            self.orderDate = try container.decode(Date.self, forKey: .orderDate)
            self.deliveryDate = try container.decodeIfPresent(Date.self, forKey: .deliveryDate)
            self.buyer = try container.decode(BuyingUser.self, forKey: .buyer)
            self.receiver = try container.decode(ReceivingUser.self, forKey: .receiver)
            self.collectionPoint = try container.decode(CollectionPoint.self, forKey: .collectionPoint)
            self.items = try container.decode([OrderItem].self, forKey: .items)
            self.totalAmount = try container.decode(Double.self, forKey: .totalAmount)
            self.paymentMethod = try container.decode(String.self, forKey: .paymentMethod)
            self.status = try container.decode(OrderStatus.self, forKey: .status)
            self.trackingNumber = try container.decodeIfPresent(String.self, forKey: .trackingNumber)
            self.deliveryAddress = try container.decode(String.self, forKey: .deliveryAddress)
            self.latitude = try container.decode(Double.self, forKey: .latitude)
            self.longitude = try container.decode(Double.self, forKey: .longitude)
            self.notes = try container.decodeIfPresent(String.self, forKey: .notes)
        }

    
    init(orderID: UUID, orderDate: Date, deliveryDate: Date? = nil, buyer: BuyingUser, receiver: ReceivingUser, collectionPoint: CollectionPoint, items: [OrderItem], totalAmount: Double, paymentMethod: String, status: OrderStatus, trackingNumber: String? = nil, deliveryAddress: String, latitude: Double, longitude: Double, notes: String? = nil) {
        
        self.orderID = orderID
        self.orderDate = orderDate
        self.deliveryDate = deliveryDate
        self.buyer = buyer
        self.receiver = receiver
        self.collectionPoint = collectionPoint
        self.items = items
        self.totalAmount = totalAmount
        self.paymentMethod = paymentMethod
        self.status = status
        self.trackingNumber = trackingNumber
        self.deliveryAddress = deliveryAddress
        self.latitude = latitude
        self.longitude = longitude
        self.notes = notes
    }
    
   
    
}


extension Order {
    func deliveryLocation() -> CLLocation {
        
        return CLLocation(latitude: latitude, longitude: longitude)

    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(orderID, forKey: .orderID)
        try container.encode(orderDate, forKey: .orderDate)
        try container.encode(deliveryDate, forKey: .deliveryDate)
        try container.encode(buyer, forKey: .buyer)
        try container.encode(receiver, forKey: .receiver)
        try container.encode(collectionPoint, forKey: .collectionPoint)
        try container.encode(items, forKey: .items)
        try container.encode(totalAmount, forKey: .totalAmount)
        try container.encode(paymentMethod, forKey: .paymentMethod)
        try container.encode(status, forKey: .status)
        try container.encode(trackingNumber, forKey: .trackingNumber)
        try container.encode(deliveryAddress, forKey: .deliveryAddress)
        try container.encode(latitude, forKey: .latitude)
        try container.encode(longitude, forKey: .longitude)
        try container.encode(notes, forKey: .notes)
    }
}

