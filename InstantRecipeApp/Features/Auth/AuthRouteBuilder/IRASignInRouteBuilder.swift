//
//  IRASignInRouteBuilder.swift
//  InstantRecipeApp
//
//  Created by Suraj Chand on 24/07/2024.
//

import LinkNavigator
import SwiftUI

struct IRASignInRouteBuilder: RouteBuilder {
  var matchPath: String { "signIn" }

  var build: (LinkNavigatorType, [String: String], DependencyType) -> MatchingViewController? {
    { navigator, items, dependency in
      return WrappingController(matchPath: matchPath, title: "") {
        IRASignInView(navigator: navigator)
      }
    }
  }
}
