//
//  Orders.swift
//  FinalChallenge
//
//  Created by Pamella Alvarenga on 27/09/24.
//

import SwiftData
import CloudKit

enum OrderStatus: String, Codable {
    case processing = "Processing"
    case shipped = "Shipped"
    case delivered = "Delivered"
    case canceled = "Canceled"
}

@Model
class Order {
    
    @Attribute(.unique)
    let orderID: UUID
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
    var deliveryLocation: CLLocation
    var notes: String?
    
    init(orderID: UUID, orderDate: Date, deliveryDate: Date? = nil, buyer: BuyingUser, receiver: ReceivingUser, collectionPoint: CollectionPoint, items: [OrderItem], totalAmount: Double, paymentMethod: String, status: OrderStatus, trackingNumber: String? = nil, deliveryAddress: String, notes: String? = nil) {
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
        self.deliveryLocation = deliveryLocation
        self.notes = notes
    }
}


@Model
final class OrderItem {
    
    @Attribute(.unique)
    let itemID: UUID
    var productName: String
    var quantity: Int
    
    @Relationship(inverse: \Order.items)
    var order: Order
    
    init(itemID: UUID, productName: String, quantity: Int) {
        self.itemID = itemID
        self.productName = productName
        self.quantity = quantity
    }
}


