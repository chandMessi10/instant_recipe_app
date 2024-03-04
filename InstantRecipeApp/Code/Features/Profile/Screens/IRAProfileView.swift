//
//  IRAProfileView.swift
//  InstantRecipeApp
//
//  Created by Suraj Chand on 27/02/2024.
//

import SwiftUI

struct IRAProfileView: View {
    
    @State private var selectedTab = 0
    let tabItems = ["Recipes", "Liked"]
    
    var body: some View {
        VStack() {
            HStack {
                Spacer()
                Button(
                    action: {},
                    label: {
                        Image(systemName: "square.and.arrow.up.fill")
                            .font(.title3)
                            .foregroundColor(.black)
                    }
                )
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 8)
            
            IRAProfileImageView(imageUrl: "https://avatars.githubusercontent.com/u/30414962?v=4")
                .padding(.bottom, 24)
            Text("Profile Name")
                .font(.system(size: 17))
                .foregroundColor(Color(UIColor(hex: "#3E5481")))
                .fontWeight(.bold)
                .padding(.bottom, 24)
            Rectangle()
                .frame(height: 8)
                .foregroundColor(Color(UIColor(hex: "#F4F5F7")))
                .padding(.bottom, 8)
            
            TabBarView(currentTab: $selectedTab)
            
            TabView(selection: $selectedTab) {
                ScrollView {
                    LazyVGrid(columns: Array(repeating: GridItem(spacing: 24), count: 2)) {
                        ForEach(1...8, id: \.self) { item in
                            ZStack(alignment: .topTrailing) {
                                VStack(alignment: .leading) {
                                    AsyncImage(
                                        url: URL(string: "https://avatars.githubusercontent.com/u/30414962?v=4")!,
                                        scale: 2
                                    )
                                    .frame(maxWidth: 180, maxHeight: 160)
                                    .background(Color.gray)
                                    .foregroundColor(.white)
                                    .cornerRadius(16)
                                    .padding(.bottom, 16)
                                    
                                    Text("Food Name")
                                        .font(.system(size: 17))
                                        .fontWeight(.bold)
                                        .foregroundColor(Color(UIColor(hex: "#3E5481")))
                                        .padding(.bottom, 8)
                                    
                                    HStack {
                                        Text("Food Name")
                                            .font(.system(size: 12))
                                            .fontWeight(.medium)
                                            .foregroundColor(Color(UIColor(hex: "#9FA5C0")))
                                        Rectangle()
                                            .clipShape(Circle())
                                            .frame(width: 5, height: 5)
                                            .padding(0)
                                            .foregroundColor(Color(UIColor(hex: "#9FA5C0")))
                                        Text(">60 mins")
                                            .font(.system(size: 12))
                                            .fontWeight(.medium)
                                            .foregroundColor(Color(UIColor(hex: "#9FA5C0")))
                                    }
                                }
                                
                                Button(
                                    action: {},
                                    label: {
                                        ZStack {
                                            Rectangle()
                                                .foregroundColor(.white).opacity(0.3)
                                                .frame(width: 32, height: 32)
                                                .cornerRadius(8)
                                            
                                            Image(systemName:  "heart")
                                            .foregroundColor(.white)
                                            .font(.system(size: 20)
                                            )
                                        }
                                        .padding(8)
                                        .offset(x: -2, y: 2)
                                    }
                                )
                            }
                            .frame(height: 230)
                            .padding(.bottom, 16)
                        }
                    }.padding(.horizontal, 16)
                }.tag(0)
                ScrollView {
                    LazyVGrid(columns: Array(repeating: GridItem(), count: 2), spacing: 16) {
                        ForEach(1...3, id: \.self) { item in
                            // Replace this with your actual grid item view
                            Rectangle()
                                .frame(height: 100)
                                .foregroundColor(.blue)
                        }
                    }
                    .padding(16)
                }.tag(1)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            
            Spacer()
        }
    }
}

#Preview {
    IRAProfileView()
}

struct TabBarView: View {
    @Binding var currentTab: Int
    @Namespace var namespace
    
    var tabBarOptions: [String] = ["Recipes", "Liked"]
    
    var body: some View {
        HStack {
            ForEach(
                Array(
                    zip(self.tabBarOptions.indices,
                        self.tabBarOptions)
                ),
                id: \.0,
                content: {
                    index, name in
                    TabBarItem(
                        currentTab: self.$currentTab,
                        namespace: namespace.self,
                        tabBarItemName: name,
                        tab: index
                    )
                    
                }
            )
        }
        .frame(height: 45)
    }
}

struct TabBarItem: View {
    @Binding var currentTab: Int
    let namespace: Namespace.ID
    
    var tabBarItemName: String
    var tab: Int
    
    var body: some View {
        Button {
            self.currentTab = tab
        } label: {
            VStack {
                Text(tabBarItemName)
                    .font(.system(size: 15))
                    .foregroundColor(Color(UIColor(hex: currentTab == tab ? "#3E5481" : "#9FA5C0")))
                    .fontWeight(.semibold)
                if currentTab == tab {
                    Color(UIColor(hex: "#1FCC79"))
                        .frame(height: 4)
                        .matchedGeometryEffect(
                            id: "underline",
                            in: namespace,
                            properties: .frame
                        )
                } else {
                    Color.clear.frame(height: 2)
                }
            }
            .animation(.spring(), value: self.currentTab)
        }
        .buttonStyle(.plain)
    }
}
