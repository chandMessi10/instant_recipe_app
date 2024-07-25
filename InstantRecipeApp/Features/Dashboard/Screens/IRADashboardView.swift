//
//  IRADashboardView.swift
//  InstantRecipeApp
//
//  Created by Suraj Chand on 23/02/2024.
//

import SwiftUI

struct IRADashboardView: View {
    @State private var selectedTab: Int = 0
    
    var body: some View {
        NavigationView {
            TabView(selection: $selectedTab) {
//                IRAHomeView()
//                    .tabItem {
//                        Label("Home", systemImage: "house")
//                    }
//                    .tag(0)
                
//                IRAProfileView()
//                    .tabItem {
//                        Label("Profile", systemImage: "person.fill")
//                    }
//                    .tag(1)
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
        .navigationBarHidden(true)
    }
}

#Preview {
    IRADashboardView()
}
