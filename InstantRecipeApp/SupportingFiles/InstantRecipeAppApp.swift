//
//  InstantRecipeAppApp.swift
//  InstantRecipeApp
//
//  Created by Suraj Chand on 21/02/2024.
//

import SwiftUI
import Appwrite
import UIPilot
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
                .launch(paths: appwriteSessionID.isEmpty ? (hasCompletedOnboarding ? ["signIn"] : ["onboarding"]) : ["addEditRecipe"], items: [:])
                .onOpenURL { url in
                    // in case you need deep link navigation,
                    // deep links should be processed here.
                }
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environment(\.colorScheme, .light)
                .ignoresSafeArea()
        }
    }
    
    //    var body: some Scene {
    //        WindowGroup {
    //            NavigationStack {
    //                if appwriteSessionID != "" {
    //                    UIPilotHost(UIPilot(initial: AppRoute.Dashboard, debug: true)) { route in
    //                        switch route {
    //                        case .Onboarding: IRAOnboardingView()
    //                        case .SignIn: IRASignInView()
    //                        case .SignUp: IRASignUpView()
    //                        case .ForgotPassword: IRAForgotPasswordView()
    //                        case .Dashboard: IRADashboardView()
    //                        case .Home: IRAHomeView()
    //                        case .Search: IRASearchView()
    //                        case .Profile: IRAProfileView()
    //                        }
    //                    }
    //                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
    //                } else {
    //                    UIPilotHost(UIPilot(initial: hasCompletedOnboarding ? AppRoute.SignIn : AppRoute.Onboarding, debug: true)) { route in
    //                        switch route {
    //                        case .Onboarding: IRAOnboardingView()
    //                        case .SignIn: IRASignInView()
    //                        case .SignUp: IRASignUpView()
    //                        case .ForgotPassword: IRAForgotPasswordView()
    //                        case .Dashboard: IRADashboardView()
    //                        case .Home: IRAHomeView()
    //                        case .Search: IRASearchView()
    //                        case .Profile: IRAProfileView()
    //                        }
    //                    }
    //                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
    //                }
    //            }
    //            .environment(\.colorScheme, .light)
    //        }
    //    }
}
