//
//  WifiGornaApp.swift
//  WifiGorna
//
//  Created by Ivan Dimitrov on 17.01.21.
//

import SwiftUI

@main
struct WifiGornaApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
