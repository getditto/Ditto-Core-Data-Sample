//
//  DittoCoreDataExampleApp.swift
//  DittoCoreDataExample
//
//  Created by Konstantin Bender on 12.11.21.
//

import SwiftUI

@main
struct DittoCoreDataExampleApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
