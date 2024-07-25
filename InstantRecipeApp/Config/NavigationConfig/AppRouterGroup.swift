//
//  AppRouterGroup.swift
//  InstantRecipeApp
//
//  Created by Suraj Chand on 24/07/2024.
//

import LinkNavigator

struct AppRouterGroup {
    var routers: [RouteBuilder] {
        [
           IRAOnboardingRouteBuilder(),
           IRASignInRouteBuilder(),
           IRAHomeRouteBuilder(),
           IRAProfileViewRouteBuilder(),
           IRASearchRouteBuilder(),
           IRARecipeDetailRouteBuilder(),
           IRAAddEditRecipeRouteBuilder()
        ]
    }
}
