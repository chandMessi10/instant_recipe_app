//
//  IRARecipeUploadSuccessRouteBuilder.swift
//  InstantRecipeApp
//
//  Created by Suraj Chand on 26/07/2024.
//

import LinkNavigator
import SwiftUI

struct IRARecipeUploadSuccessRouteBuilder: RouteBuilder {
    var matchPath: String { "recipeUploadSuccess" }
    
    var build: (LinkNavigatorType, [String: String], DependencyType) -> MatchingViewController? {
        { navigator, items, dependency in
            return WrappingController(matchPath: matchPath, title: "") {
                IRARecipeUploadSuccessView(navigator: navigator)
            }
        }
    }
}
