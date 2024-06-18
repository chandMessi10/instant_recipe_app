//
//  InstantRecipeAppApp.swift
//  InstantRecipeApp
//
//  Created by Suraj Chand on 21/02/2024.
//

import SwiftUI
import Appwrite

@main
struct InstantRecipeAppApp: App {
    let persistenceController = PersistenceController.shared
    
    // AppStorage property to track onboarding completion
    @AppStorage("hasCompletedOnboarding") var hasCompletedOnboarding: Bool = false
    
    // Ensure the singleton is accessed when the app starts
    init() {
        _ = ClientManager.shared
    }

    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                if hasCompletedOnboarding {
                    IRASignInView()
                        .environment(\.managedObjectContext, persistenceController.container.viewContext)
                } else {
                    IRAOnboardingView()
                        .environment(\.managedObjectContext, persistenceController.container.viewContext)
                }
            }
            .environment(\.colorScheme, .light)
            .navigationViewStyle(.stack)
        }
    }
}
