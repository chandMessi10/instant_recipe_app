//
//  IRARecipeDetailRouteBuilder.swift
//  InstantRecipeApp
//
//  Created by Suraj Chand on 25/07/2024.
//

import LinkNavigator
import SwiftUI

struct IRARecipeDetailRouteBuilder: RouteBuilder {
  var matchPath: String { "recipeDetail" }

  var build: (LinkNavigatorType, [String: String], DependencyType) -> MatchingViewController? {
    { navigator, items, dependency in
      return WrappingController(matchPath: matchPath, title: "") {
        IRARecipeDetailView(navigator: navigator)
      }
    }
  }
}
