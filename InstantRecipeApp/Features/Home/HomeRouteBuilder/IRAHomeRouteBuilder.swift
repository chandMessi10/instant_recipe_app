//
//  IRADashboardRouteBuilder.swift
//  InstantRecipeApp
//
//  Created by Suraj Chand on 24/07/2024.
//

import LinkNavigator
import SwiftUI

struct IRAHomeRouteBuilder: RouteBuilder {
  var matchPath: String { "home" }

  var build: (LinkNavigatorType, [String: String], DependencyType) -> MatchingViewController? {
    { navigator, items, dependency in
      return WrappingController(matchPath: matchPath, title: "") {
        IRAHomeView(navigator: navigator)
      }
    }
  }
}
