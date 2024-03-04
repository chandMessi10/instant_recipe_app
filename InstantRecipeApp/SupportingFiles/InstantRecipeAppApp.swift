//
//  InstantRecipeAppApp.swift
//  InstantRecipeApp
//
//  Created by Suraj Chand on 21/02/2024.
//

import SwiftUI

@main
struct InstantRecipeAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            IRAOnboardingView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
//                .navigationViewStyle(.stack)
        }
    }
}
