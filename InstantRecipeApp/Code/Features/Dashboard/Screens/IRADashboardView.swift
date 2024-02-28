//
//  IRADashboardView.swift
//  InstantRecipeApp
//
//  Created by Suraj Chand on 23/02/2024.
//

import SwiftUI

struct IRADashboardView: View {
    var body: some View {
        NavigationView {
            TabView {
                IRAHomeView()
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                IRAProfileView()
                    .tabItem {
                        Label("Profile", systemImage: "person.fill")
                    }
            }
            .onAppear {
                // correct the transparency bug for Tab bars
                let tabBarAppearance = UITabBarAppearance()
                tabBarAppearance.configureWithOpaqueBackground()
                UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
                // correct the transparency bug for Navigation bars
                let navigationBarAppearance = UINavigationBarAppearance()
                navigationBarAppearance.configureWithOpaqueBackground()
                UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
            }
            .accentColor(Color(UIColor(hex: "#1FCC79")))
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    IRADashboardView()
}
