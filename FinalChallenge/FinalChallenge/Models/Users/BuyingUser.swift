
import Foundation
import CloudKit
import SwiftData


@Model
class BuyingUser: UserProtocol, Codable {
    
    @Attribute(.unique)
    var id = UUID().uuidString
    @Attribute(.unique)
    var CPF: String
    var name: String
    var adress: DeliveryAddress
    var phone: String
    var email: String
    var latitude: Double
    var longitude: Double
    var identifyVerified: Bool
    var preferredPickupLocation: CollectionPoint?
    var paymentMethod: String? //alterar para um tipo mais adequado futuramente, talvez um enum
    var orderHistory: [Order] = []
    var notificationsEnabled: Bool
    var favoriteReceivers: [ReceivingUser]?
    
    @Relationship(deleteRule: .cascade) var currentOrders: [Order] = []
    var loyaltyPoints: Int
    var savedPreferences: String
    
    private enum CodingKeys: String, CodingKey {
            case id, CPF, name, adress, phone, email, latitude, longitude, identifyVerified, preferredPickupLocation, paymentMethod, orderHistory, notificationsEnabled, favoriteReceivers, currentOrders, loyaltyPoints, savedPreferences
        }
    

    required init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.id = try container.decode(String.self, forKey: .id)
            self.CPF = try container.decode(String.self, forKey: .CPF)
            self.name = try container.decode(String.self, forKey: .name)
            self.adress = try container.decode(DeliveryAddress.self, forKey: .adress)
            self.phone = try container.decode(String.self, forKey: .phone)
            self.email = try container.decode(String.self, forKey: .email)
            self.latitude = try container.decode(Double.self, forKey: .latitude)
            self.longitude = try container.decode(Double.self, forKey: .longitude)
            self.identifyVerified = try container.decode(Bool.self, forKey: .identifyVerified)
            self.preferredPickupLocation = try container.decodeIfPresent(CollectionPoint.self, forKey: .preferredPickupLocation)
            self.paymentMethod = try container.decodeIfPresent(String.self, forKey: .paymentMethod)
            self.orderHistory = try container.decode([Order].self, forKey: .orderHistory)
            self.notificationsEnabled = try container.decode(Bool.self, forKey: .notificationsEnabled)
            self.favoriteReceivers = try container.decodeIfPresent([ReceivingUser].self, forKey: .favoriteReceivers)
            self.currentOrders = try container.decode([Order].self, forKey: .currentOrders)
            self.loyaltyPoints = try container.decode(Int.self, forKey: .loyaltyPoints)
            self.savedPreferences = try container.decode(String.self, forKey: .savedPreferences)
        }
    
    init(CPF: String, name: String, adress: DeliveryAddress, phone: String, email: String,latitude: Double, longitude: Double, identifyVerified: Bool, preferredPickupLocation: CollectionPoint? , paymentMethod: String? = nil, orderHistory: [Order], reviewsGi ven: [Review]?, notificationsEnabled: Bool, favoriteReceivers: [ReceivingUser]? = nil, currentOrders: [Order], loyaltyPoints: Int, savedPreferences: String) {
        
        self.CPF = CPF
        self.name = name
        self.adress = adress
        self.phone = phone
        self.email = email
        self.latitude = latitude
        self.longitude = longitude
        self.identifyVerified = false
        self.preferredPickupLocation = preferredPickupLocation
        self.paymentMethod = paymentMethod
        self.orderHistory = orderHistory
        self.notificationsEnabled = notificationsEnabled
        self.favoriteReceivers = favoriteReceivers
        self.currentOrders = currentOrders
        self.loyaltyPoints = loyaltyPoints
        self.savedPreferences = savedPreferences
    }
    
}



extension BuyingUser {
    
    func encode(to encoder: Encoder) throws {
           var container = encoder.container(keyedBy: CodingKeys.self)
           try container.encode(id, forKey: .id)
           try container.encode(CPF, forKey: .CPF)
           try container.encode(name, forKey: .name)
           try container.encode(adress, forKey: .adress)
           try container.encode(phone, forKey: .phone)
           try container.encode(email, forKey: .email)
           try container.encode(latitude, forKey: .latitude)
           try container.encode(longitude, forKey: .longitude)
           try container.encode(identifyVerified, forKey: .identifyVerified)
           try container.encode(preferredPickupLocation, forKey: .preferredPickupLocation)
           try container.encode(paymentMethod, forKey: .paymentMethod)
           try container.encode(orderHistory, forKey: .orderHistory)
           try container.encode(notificationsEnabled, forKey: .notificationsEnabled)
           try container.encode(favoriteReceivers, forKey: .favoriteReceivers)
           try container.encode(currentOrders, forKey: .currentOrders)
           try container.encode(loyaltyPoints, forKey: .loyaltyPoints)
           try container.encode(savedPreferences, forKey: .savedPreferences)
       }
    
    func deleteUser(_ user: BuyingUser, context: ModelContext) {
        
        if currentOrders.count > 0 {
            for order in user.currentOrders {
                context.delete(order)
            }
        }
        context.delete(user)

        try? context.save()

    }
    
    func location() -> CLLocation {
        return CLLocation(latitude: latitude, longitude: longitude)

    }
    
   
       
}
