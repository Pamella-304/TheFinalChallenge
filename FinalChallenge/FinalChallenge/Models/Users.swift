
import Foundation
import CloudKit
import SwiftData


// ao adiocionarmos esse modificador, já estamos definindo como será nosso data schema (só funciona com classes).
@Model
class User {
    
    //ainda é necessário definir um ID para identificação na nuvem
    var id = UUID().uuidString
    var CPF: String
    var name: String
    var adress: DeliveryAddress
    var phone: String
    var email: String
    //var location: CLLocation
    
    var identifyVerified: Bool

    
    init(CPF: String, name: String, adress: DeliveryAddress, phone: String, email: String, identifyVerified: Bool) {
        
        self.CPF = CPF
        self.name = name
        self.adress = adress
        self.phone = phone
        self.email = email
       // self.location = location
        self.identifyVerified = false
    }
}


@Model
class ReceivingUser: User {
    
    var availability: String
    var abcenses: [String]
    var mediumRate: Double
    var numReviews: Int
    var comments: [String]
    var storageCapacity: Int
    var packagesTipe: [String]
    var storageConditions: String
    var documents: [CKAsset]
    var recievedPackagesHistory: [CKRecord.Reference]
    var currentStatus: String
    
    init(availability: String, abcenses: [String], mediumRate: Double, numReviews: Int, comments: [String], storageCapacity: Int, packagesTipe: [String], storageConditions: String, documents: [CKAsset], recievedPackagesHistory: [CKRecord.Reference], currentStatus: String) {
        self.availability = availability
        self.abcenses = abcenses
        self.mediumRate = mediumRate
        self.numReviews = numReviews
        self.comments = comments
        self.storageCapacity = storageCapacity
        self.packagesTipe = packagesTipe
        self.storageConditions = storageConditions
        self.documents = documents
        self.recievedPackagesHistory = recievedPackagesHistory
        self.currentStatus = currentStatus
    }
    
    required init(backingData: any SwiftData.BackingData<User>) {
        fatalError("init(backingData:) has not been implemented")
    }
    
}


class BuyingUser: User {
     
    var preferredPickupLocation: String? // alterar para um tipo mais dequado futuramente
    var paymentMethod: String? //alterar para um tipo mais adequado futuramente, talvez um enum
    var orderHistory: [Order] //ainda falta definir essa entidade
    var reviewsGiven: [Review] // ainda falta definir essa entidade
    var notificationsEnabled: Bool
    var favoriteReceivers: [ReceivingUser]?
    var currentOrders: [Order]
    var loyaltyPoints: Int
    var savedPreferences: [String: Any]

    init(preferredPickupLocation: String? = nil, paymentMethod: String? = nil, orderHistory: [Order], reviewsGiven: [Review], notificationsEnabled: Bool, favoriteReceivers: [ReceivingUser]? = nil, currentOrders: [Order], loyaltyPoints: Int, savedPreferences: [String : Any]) {
        self.preferredPickupLocation = preferredPickupLocation
        self.paymentMethod = paymentMethod
        self.orderHistory = orderHistory
        self.reviewsGiven = reviewsGiven
        self.notificationsEnabled = notificationsEnabled
        self.favoriteReceivers = favoriteReceivers
        self.currentOrders = currentOrders
        self.loyaltyPoints = loyaltyPoints
        self.savedPreferences = savedPreferences
    }
    
    required init(backingData: any SwiftData.BackingData<User>) {
        fatalError("init(backingData:) has not been implemented")
    }
    
    
}

struct DeliveryAddress: Codable {
    var street: String
    var city: String
    var state: String
    var postalCode: String
    var country: String
}

func saveUserLocally(user: User, context: ModelContext) {
    context.insert(user)
    do {
        try context.save()
        print("User saved locally")
    } catch {
        print("Error saving user locally: \(error.localizedDescription)")
    }
}

