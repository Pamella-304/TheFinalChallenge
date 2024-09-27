

import CloudKit //Ainda não foi decidido se usaremos CloudKit ou SwiftData
//não esquecer que é necessária persistência local além da remota


class User {
    
    //ainda é necessário definir um ID para identificação na nuvem
    let CPF: String
    var name: String
    var adess: String
    var phone: String
    var email: String
    var location: CLLocation
    var identifyVerified: Bool

    
    init(CPF: String, name: String, adess: String, phone: String, email: String, location: CLLocation, identifyVerified: Bool) {
        self.CPF = CPF
        self.name = name
        self.adess = adess
        self.phone = phone
        self.email = email
        self.location = location
        self.identifyVerified = false
    }

}

class RecievingUser: User {
    
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
    
}


class BuyingUser: User {
     
    var preferredPickupLocation: String? // alterar para um tipo mais dequado futuramente
    var paymentMethod: String? //alterar para um tipo mais adequado futuramente, talvez um enum
    var orderHistory: [Order] //ainda falta definir essa entidade
    var reviewsGiven: [Review] // ainda falta definir essa entidade
    var notificationsEnabled: Bool
    var favoriteReceivers: [RecievingUser]?
    var currentOrders: [Order]
    var loyaltyPoints: Int
    var savedPreferences: [String: Any]

    init(preferredPickupLocation: String? = nil, paymentMethod: String? = nil, orderHistory: [Order], reviewsGiven: [Review], notificationsEnabled: Bool, favoriteReceivers: [RecievingUser]? = nil, currentOrders: [Order], loyaltyPoints: Int, savedPreferences: [String : Any]) {
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
    
    
}









//let recebedorRecord = CKRecord(recordType: "Recebedor")
//
//recebedorRecord["nome"] = "Maria da Silva"
//recebedorRecord["endereco"] = "Rua das Flores, 123, São Paulo, SP, 01234-567"
//recebedorRecord["telefone"] = "+55 (11) 99999-9999"
//recebedorRecord["email"] = "maria@example.com"
//recebedorRecord["disponibilidade"] = "Segunda a Sexta, 9h às 18h"
//recebedorRecord["ausencias"] = ["2024-12-24", "2024-12-25"]
//recebedorRecord["avaliacaoMedia"] = 4.8
//recebedorRecord["numAvaliacoes"] = 20
//recebedorRecord["comentarios"] = ["Serviço excelente!", "Recebedora muito atenciosa."]
//recebedorRecord["capacidade"] = 10
//recebedorRecord["tiposPacotes"] = ["Pequenos", "Médios"]
//recebedorRecord["condicoesArmazenamento"] = "Ambiente seco e seguro"
//recebedorRecord["localizacao"] = CLLocation(latitude: -23.5505, longitude: -46.6333)
//recebedorRecord["verificacaoIdentidade"] = true
//recebedorRecord["documentos"] = ["RG", "Comprovante de Residência"]
//recebedorRecord["historicoPacotes"] = []  // Inicialmente vazio
//recebedorRecord["statusAtual"] = "Disponível"






//Classe para verificar se o app tem acesso ao database:
//
//class CloudKitAccesChecker {
//    static func checkAccess() {
//        
//        let container = CKContainer.default()
//        
//        container.accountStatus { status, error in
//            
//            if status == .available {
//                print("App tem acesso ao database")
//            }
//            
//        }
//    }
//}
//

