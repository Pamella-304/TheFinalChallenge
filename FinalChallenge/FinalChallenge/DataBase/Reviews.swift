//
//  Untitled.swift
//  FinalChallenge
//
//  Created by Pamella Alvarenga on 27/09/24.
//

import Foundation
import CloudKit

enum ReviewRating: Int {
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

class Review {
    let reviewID: String // ID único da avaliação
    let reviewer: BuyingUser // Usuário que escreveu a avaliação
    let receiver: ReceivingUser // Usuário recebedor avaliado
    var rating: ReviewRating // Avaliação dada
    var comment: String? // Comentário opcional
    var date: Date // Data em que a avaliação foi escrita
    var order: Order // ID do pedido associado à avaliação
    
    init(reviewID: String, reviewer: BuyingUser, receiver: ReceivingUser, rating: ReviewRating, comment: String?, date: Date, order: Order) {
        self.reviewID = reviewID
        self.reviewer = reviewer
        self.receiver = receiver
        self.rating = rating
        self.comment = comment
        self.date = date
        self.order = order
    }
}
