//
//  Untitled.swift
//  FinalChallenge
//
//  Created by Pamella Alvarenga on 27/09/24.
//

import Foundation
import SwiftData

enum ReviewRating: Int, Codable {
    case oneStar = 1
       case twoStars
       case threeStars
       case fourStars
       case fiveStars
       
       var description: String {
           switch self {
           case .oneStar: return "⭐"
           case .twoStars: return "⭐⭐"
           case .threeStars: return "⭐⭐⭐"
           case .fourStars: return "⭐⭐⭐⭐"
           case .fiveStars: return "⭐⭐⭐⭐⭐"
           }
       }
}

@Model
class Review: Codable {
    var reviewID: String // ID único da avaliação
    
    @Relationship(inverse: \BuyingUser.name)
    let reviewer: BuyingUser // Usuário que escreveu a avaliação
    
    @Relationship(inverse: \ReceivingUser.name)
    let receiver: ReceivingUser // Usuário recebedor avaliado
    var rating: ReviewRating
    var comment: String?
    var date: Date
    var order: Order
    
    enum CodingKeys: String, CodingKey {
            case reviewID, reviewer, receiver, rating, comment, date, order
        }
    
    init(reviewID: String, reviewer: BuyingUser, receiver: ReceivingUser, rating: ReviewRating, comment: String?, date: Date, order: Order) {
        self.reviewID = reviewID
        self.reviewer = reviewer
        self.receiver = receiver
        self.rating = rating
        self.comment = comment
        self.date = date
        self.order = order
    }
    
    required init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.reviewID = try container.decode(String.self, forKey: .reviewID)
            self.reviewer = try container.decode(BuyingUser.self, forKey: .reviewer)
            self.receiver = try container.decode(ReceivingUser.self, forKey: .receiver)
            self.rating = try container.decode(ReviewRating.self, forKey: .rating)
            self.comment = try container.decodeIfPresent(String.self, forKey: .comment)
            self.date = try container.decode(Date.self, forKey: .date)
            self.order = try container.decode(Order.self, forKey: .order)
    }
    
   
    
}

extension Review {
    
    func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(reviewID, forKey: .reviewID)
            try container.encode(reviewer, forKey: .reviewer)
            try container.encode(receiver, forKey: .receiver)
            try container.encode(rating, forKey: .rating)
            try container.encodeIfPresent(comment, forKey: .comment)
            try container.encode(date, forKey: .date)
            try container.encode(order, forKey: .order)
        }
    
    func addReview(from buyingUser: BuyingUser, to receivingUser: ReceivingUser, context: ModelContext, comment: String?, order: Order) {
        

        let newReview = Review(reviewID: UUID().uuidString, reviewer: buyingUser, receiver: receivingUser, rating: .oneStar, comment: comment, date: Date(), order: order)
                                   
        
        receivingUser.reviewsReceived.append(newReview)
        
        context.insert(newReview)
        
        do {
                try context.save()
                print("Review added and saved successfully.")
            } catch {
                print("Failed to save review: \(error.localizedDescription)")
            }
    }
}
