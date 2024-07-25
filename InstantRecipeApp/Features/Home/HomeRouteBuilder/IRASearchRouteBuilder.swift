//
//  IRASearchRouteBuilder.swift
//  InstantRecipeApp
//
//  Created by Suraj Chand on 25/07/2024.
//

import LinkNavigator
import SwiftUI

struct IRASearchRouteBuilder: RouteBuilder {
  var matchPath: String { "search" }

  var build: (LinkNavigatorType, [String: String], DependencyType) -> MatchingViewController? {
    { navigator, items, dependency in
      return WrappingController(matchPath: matchPath, title: "") {
        IRASearchView(navigator: navigator)
      }
    }
  }
}
