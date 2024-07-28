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
            IRARecipeDetailView(
                navigator: navigator,
                recipeName: extractDetail(from: items, key: "recipeName"),
                recipeImageId: extractDetail(from: items, key: "recipeImageId"),
                recipeDescription: extractDetail(from: items, key: "recipeDescription"),
                recipeCategory: extractDetail(from: items, key: "recipeCategory"),
                recipeCookingTime: extractDetail(from: items, key: "recipeCookingTime"),
                chefName: extractDetail(from: items, key: "chefName")
            )
        }
    }
  }
}
