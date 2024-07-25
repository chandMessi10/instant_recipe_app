//
//  IRAProfileViewRouteBuilder.swift
//  InstantRecipeApp
//
//  Created by Suraj Chand on 25/07/2024.
//

import LinkNavigator
import SwiftUI

struct IRAProfileViewRouteBuilder: RouteBuilder {
  var matchPath: String { "profile" }

  var build: (LinkNavigatorType, [String: String], DependencyType) -> MatchingViewController? {
    { navigator, items, dependency in
      return WrappingController(matchPath: matchPath, title: "") {
        IRAProfileView(navigator: navigator)
      }
    }
  }
}
