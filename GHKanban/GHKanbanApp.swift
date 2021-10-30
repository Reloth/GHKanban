//
//  GHKanbanApp.swift
//  GHKanban
//
//  Created by Diego on 30/10/21.
//

import SwiftUI

@main
struct GHKanbanApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
