//
//  DiscGolfBagManagerApp.swift
//  DiscGolfBagManager
//
//  Created by Finley Vickers on 2024-10-13.
//

import SwiftUI

@main
struct DiscGolfBagManagerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
