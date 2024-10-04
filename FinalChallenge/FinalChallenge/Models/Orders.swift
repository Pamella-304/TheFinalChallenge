//
//  Orders.swift
//  FinalChallenge
//
//  Created by Pamella Alvarenga on 27/09/24.
//

import SwiftData
import SwiftUI
import CoreLocation

enum OrderStatus: String, Codable {
    case processing = "Processing"
    case shipped = "Shipped"
    case delivered = "Delivered"
    case canceled = "Canceled"
}

@Model
class Order {
    let orderID: UUID
    var orderDae: Date
    var deliveryDate: Date?
    var buyer: BuyingUser
    var receiver: ReceivingUser?
    var items: [OrderItem]
    var totalAmount: Double
    var paymentMethod: String
    var status: OrderStatus
    var trackingNumber: String?
    var deliveryAddress: String // escolher um tipo mais adequado futuramente
   // var deliveryLocation: CLLocation
    var notes: String?
    
    init(orderID: UUID, orderDae: Date, deliveryDate: Date? = nil, buyer: BuyingUser, receiver: ReceivingUser? = nil, items: [OrderItem], totalAmount: Double, paymentMethod: String, status: OrderStatus, trackingNumber: String? = nil, deliveryAddress: String, notes: String? = nil) {
        self.orderID = orderID
        self.orderDae = orderDae
        self.deliveryDate = deliveryDate
        self.buyer = buyer
        self.receiver = receiver
        self.items = items
        self.totalAmount = totalAmount
        self.paymentMethod = paymentMethod
        self.status = status
        self.trackingNumber = trackingNumber
        self.deliveryAddress = deliveryAddress
     //   self.deliveryLocation = deliveryLocation
        self.notes = notes
    }
}


@Model
class OrderItem {
    let itemID: UUID
    var productName: String
    var quantity: Int
    var pricePerUnit: Double
    
    init(itemID: UUID, productName: String, quantity: Int, pricePerUnit: Double) {
        self.itemID = itemID
        self.productName = productName
        self.quantity = quantity
        self.pricePerUnit = pricePerUnit
    }
}


