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
class Review {
    var reviewID: String // ID único da avaliação
    
    @Relationship(inverse: \BuyingUser.name)
    let reviewer: BuyingUser // Usuário que escreveu a avaliação
    
    @Relationship(inverse: \ReceivingUser.name)
    let receiver: ReceivingUser // Usuário recebedor avaliado
    var rating: ReviewRating
    var comment: String?
    var date: Date
    //var order: Order
    
    init(reviewID: String, reviewer: BuyingUser, receiver: ReceivingUser, rating: ReviewRating, comment: String?, date: Date) {
        self.reviewID = reviewID
        self.reviewer = reviewer
        self.receiver = receiver
        self.rating = rating
        self.comment = comment
        self.date = date
//        self.order = order
    }
    
    func addReview(from buyingUser: BuyingUser, to receivingUser: ReceivingUser, context: ModelContext, comment: String?) {
        

            let newReview = Review(reviewID: UUID().uuidString, reviewer: buyingUser, receiver: receivingUser, rating: .oneStar, comment: comment, date: Date())
                                   
        
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
