//
//  AppDelegate.swift
//  InstantRecipeApp
//
//  Created by Suraj Chand on 24/07/2024.
//
// A type that manages the navigator injected with external dependencies and pages.

import SwiftUI
import LinkNavigator

final class AppDelegate: NSObject {
    var navigator: LinkNavigator {
        LinkNavigator(dependency: AppDependency(), builders: AppRouterGroup().routers)
    }
}

extension AppDelegate: UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        true
    }
}
