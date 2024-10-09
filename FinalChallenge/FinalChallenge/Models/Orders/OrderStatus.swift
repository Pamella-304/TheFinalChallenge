//
//  OrderStatus.swift
//  FinalChallenge
//
//  Created by Pamella Alvarenga on 08/10/24.
//

enum OrderStatus: String, Codable {
    case processing = "Processing"
    case shipped = "Shipped"
    case delivered = "Delivered"
    case canceled = "Canceled"
}
