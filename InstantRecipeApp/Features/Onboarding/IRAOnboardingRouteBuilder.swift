//
//  IRAOnboardingRouteBuilder.swift
//  InstantRecipeApp
//
//  Created by Suraj Chand on 24/07/2024.

import LinkNavigator
import SwiftUI

struct IRAOnboardingRouteBuilder: RouteBuilder {
  var matchPath: String { "onboarding" }

  var build: (LinkNavigatorType, [String: String], DependencyType) -> MatchingViewController? {
    { navigator, items, dependency in
      return WrappingController(matchPath: matchPath, title: "") {
        IRAOnboardingView(navigator: navigator)
      }
    }
  }
}
