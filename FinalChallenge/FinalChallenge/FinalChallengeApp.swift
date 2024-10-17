//
//  FinalChallengeApp.swift
//  FinalChallenge
//
//  Created by Pamella Alvarenga on 23/09/24.
//

import SwiftUI
import SwiftData

@main
struct FinalChallengeApp: App {
    
    @MainActor
    var sharedModelContainer: ModelContainer = {
     
        let schema = Schema([ReceivingUser.self, BuyingUser.self])
        let config = ModelConfiguration(schema: schema, cloudKitDatabase: .none)
        
        do {
            return try ModelContainer(for: schema, configurations: [config])
        } catch {
            fatalError("Error: \(error.localizedDescription)")
        }
    }()

    init() {
        resetLocalData() // Limpa os dados ao iniciar o app
    }
    
    var body: some Scene {
        WindowGroup {
            
            ContentView()
            
        }
        .modelContainer(sharedModelContainer)
        
    }
    
    
    func resetLocalData() {
        let fileManager = FileManager.default
        
        if let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first {
            
            print("Document Directory: \(documentsDirectory)")  // Exibe o diretório de documentos

            do {
                // Apagar todos os arquivos .sqlite e associados (jornal, wal)
                let sqlitePaths = ["FinalChallenge.sqlite", "FinalChallenge.sqlite-shm", "FinalChallenge.sqlite-wal"]
                
                for sqlitePath in sqlitePaths {
                    let sqliteFile = documentsDirectory.appendingPathComponent(sqlitePath)
                    if fileManager.fileExists(atPath: sqliteFile.path) {
                        try fileManager.removeItem(at: sqliteFile)
                        print("Arquivo \(sqlitePath) removido com sucesso.")
                    }
                }
            } catch {
                print("Erro ao remover banco de dados local: \(error.localizedDescription)")
            }
        }
    }
}
