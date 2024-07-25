//
//  RoutingConfig.swift
//  InstantRecipeApp
//
//  Created by Suraj Chand on 20/06/2024.
//

import Foundation
import SwiftUI

final class Router: ObservableObject {
    
    public enum Destination: Codable, Hashable {
        case signIn
        case signUp
        case dashboard
        case home
        case profile
        case search
    }
    
    @Published var navPath = NavigationPath()
    
    func navigate(to destination: Destination) {
        navPath.append(destination)
    }
    
    func navigateBack() {
        navPath.removeLast()
    }
    
    func navigateToRoot() {
        navPath.removeLast(navPath.count)
    }
    
    func navigateAndReplace(to destination: Destination) {
        navPath.removeLast(navPath.count)
        navPath.append(destination)
    }
}
