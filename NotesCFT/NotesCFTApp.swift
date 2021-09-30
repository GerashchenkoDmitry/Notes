//
//  NotesCFTApp.swift
//  NotesCFT
//
//  Created by Дмитрий Геращенко on 30.09.2021.
//

import SwiftUI

@main
struct NotesCFTApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
