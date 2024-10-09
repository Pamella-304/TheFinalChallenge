//
//  FinalChallengeApp.swift
//  FinalChallenge
//
//  Created by Pamella Alvarenga on 23/09/24.
//

import SwiftUI

@main
struct FinalChallengeApp: App {
    
    
    @State private var resetComplete = false // Controla o reset

        var body: some Scene {
            WindowGroup {
                    ContentView()
                        .modelContainer(for: [ReceivingUser.self, BuyingUser.self])
                }
            }
        
    
    func resetLocalData() {
        let fileManager = FileManager.default
        
        if let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first {
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
