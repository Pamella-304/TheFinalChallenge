//
//  ContentView.swift
//  FinalChallenge
//
//  Created by Pamella Alvarenga on 23/09/24.
//


//import CloudKit
import SwiftUI
import SwiftData

struct ContentView: View {
    
    @Environment(\.modelContext) var modelContext
    
    @Query var receivingUsers: [ReceivingUser]
    @Query var buyingUsers: [BuyingUser]
    
    var body: some View {
        
        let userService = UserService()

           VStack {
               Text("Hello")
               
               Button(action: {
                   // Exemplo de criação de um novo usuário
                   let address = DeliveryAddress(street: "123 Main St", city: "São Paulo", state: "SP", postalCode: "12345-678", country: "Brazil")
                  // let location = CLLocation(latitude: -23.5505, longitude: -46.6333) // Localização de exemplo
                   
                   let newUser = BuyingUser(CPF: "123.456.789-00", name: "Pamella Alvarenga", adress: address, phone: "99999-9999", email: "pamella@example.com",latitude: 0.0, longitude: 0.0, identifyVerified: false, preferredPickupLocation: nil, paymentMethod: nil, orderHistory: [], reviewsGi: [], notificationsEnabled: true, favoriteReceivers: nil, currentOrders: [], loyaltyPoints: 0, savedPreferences: "none")
                   
                   // Chamar o serviço para salvar o novo usuário
                   userService.registerUser(user: newUser, context: modelContext)
                   
               }) {
                   Text("Salvar novo usuário")
                       .padding()
                       .background(Color.blue)
                       .foregroundColor(.white)
                       .cornerRadius(8)
               }
               
               List {
                   ForEach(buyingUsers) { user in
                       Text(user.name)
                       Text(user.CPF)
                       Text(user.adress.city)
                           .swipeActions {
                               Button(role: .destructive) {
                                   withAnimation {
                                       modelContext.delete(user)
                                   }
                               } label: {
                                   Label("Delete", systemImage: "thash.fill")
                               }
                           }
                   }
               }
           }
       }
  
}

