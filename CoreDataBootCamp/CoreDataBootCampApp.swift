//
//  CoreDataBootCampApp.swift
//  CoreDataBootCamp
//
//  Created by Vincent Joy on 27/12/24.
//

import SwiftUI

@main
struct CoreDataBootCampApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
