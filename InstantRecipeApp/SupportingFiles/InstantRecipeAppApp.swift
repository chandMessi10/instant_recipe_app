//
//  InstantRecipeAppApp.swift
//  InstantRecipeApp
//
//  Created by Suraj Chand on 21/02/2024.
//

import SwiftUI
import Appwrite
import LinkNavigator

@main
struct InstantRecipeAppApp: App {
    let persistenceController = PersistenceController.shared
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    
    var navigator: LinkNavigator {
        appDelegate.navigator
    }
    
    // AppStorage property to track onboarding completion
    @AppStorage("hasCompletedOnboarding") var hasCompletedOnboarding: Bool = false
    // AppStorage property to keep appwrite session id
    @AppStorage("appwriteSessionID") var appwriteSessionID: String = ""
    
    // Ensure the singleton is accessed when the app starts
    init() {
        _ = ClientManager.shared
    }
    
    var body: some Scene {
        WindowGroup {
            navigator
                .launch(paths: appwriteSessionID == "" ? (hasCompletedOnboarding ? ["signIn"] : ["onboarding"]) : ["home"], items: [:],prefersLargeTitles: false)
                .onOpenURL { url in
                    // in case you need deep link navigation,
                    // deep links should be processed here.
                }
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environment(\.colorScheme, .light)
                .ignoresSafeArea()
        }
    }
}
