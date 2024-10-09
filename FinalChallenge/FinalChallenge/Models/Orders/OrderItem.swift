//
//  OrderItem.swift
//  FinalChallenge
//
//  Created by Pamella Alvarenga on 08/10/24.
//

import SwiftData
import CloudKit

@Model
final class OrderItem: Codable {
    
    @Attribute(.unique)
    let itemID: UUID
    var productName: String
    var quantity: Int

    @Relationship(inverse: \Order.items)
    var order: Order
    
    enum CodingKeys: String, CodingKey {
        case itemID, productName, quantity, order
    }
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.itemID = try container.decode(UUID.self, forKey: .itemID)
        self.productName = try container.decode(String.self, forKey: .productName)
        self.quantity = try container.decode(Int.self, forKey: .quantity)
        self.order = try container.decode(Order.self, forKey: .order)
    }
    
    init(itemID: UUID, productName: String, quantity: Int, order: Order) {
        self.itemID = itemID
        self.productName = productName
        self.quantity = quantity
        self.order = order
    }
}


extension OrderItem {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(itemID, forKey: .itemID)
        try container.encode(productName, forKey: .productName)
        try container.encode(quantity, forKey: .quantity)
        try container.encode(order, forKey: .order)
    }
}
