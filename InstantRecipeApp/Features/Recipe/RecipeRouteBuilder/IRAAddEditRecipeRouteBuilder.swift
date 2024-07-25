//
//  IRAAddEditRecipeRouteBuilder.swift
//  InstantRecipeApp
//
//  Created by Suraj Chand on 25/07/2024.
//

import LinkNavigator
import SwiftUI

struct IRAAddEditRecipeRouteBuilder: RouteBuilder {
  var matchPath: String { "addEditRecipe" }

  var build: (LinkNavigatorType, [String: String], DependencyType) -> MatchingViewController? {
    { navigator, items, dependency in
      return WrappingController(matchPath: matchPath, title: "") {
        IRAAddEditRecipeView(navigator: navigator)
      }
    }
  }
}
