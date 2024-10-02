//
//  ContentView.swift
//  FinalChallenge
//
//  Created by Pamella Alvarenga on 23/09/24.
//


import CloudKit
import SwiftUI
import SwiftData

struct ContentView: View {
    
    @Environment(\.modelContext) var modelContext
    
    //Variável de serviço para gerenciar o ususário
    @StateObject var userService: UserService
    
 
    
    var body: some View {
        
        let userService = UserService(context: modelContext)

           VStack {
               Text("Hello")
               
               Button(action: {
                   // Exemplo de criação de um novo usuário
                   let address = DeliveryAddress(street: "123 Main St", city: "São Paulo", state: "SP", postalCode: "12345-678", country: "Brazil")
                   let location = CLLocation(latitude: -23.5505, longitude: -46.6333) // Localização de exemplo
                   
                   let newUser = User(CPF: "123.456.789-00", name: "Pamella Alvarenga", adress: address, phone: "99999-9999", email: "pamella@example.com", identifyVerified: false)
                   
                   // Chamar o serviço para salvar o novo usuário
                   userService.registerUser(user: newUser)
                   
               }) {
                   Text("Salvar novo usuário")
                       .padding()
                       .background(Color.blue)
                       .foregroundColor(.white)
                       .cornerRadius(8)
               }
           }
       }
  
}

