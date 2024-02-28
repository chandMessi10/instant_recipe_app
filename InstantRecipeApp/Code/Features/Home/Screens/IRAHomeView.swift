//
//  IRAHomeView.swift
//  InstantRecipeApp
//
//  Created by Suraj Chand on 23/02/2024.
//

import SwiftUI

struct IRAHomeView: View {
    @State private var isTapped: Bool = false
    @State private var selectedOptions: Set<String> = ["All"]
    let options = ["All", "Food", "Drink"]
    
    var body: some View {
        ZStack {
            VStack {
                // Search
                NavigationLink(destination: IRASearchView()) {
                    ZStack {
                        Rectangle()
                            .foregroundColor(Color(UIColor(hex: "#F4F5F7")))
                            .frame(height: 56)
                            .cornerRadius(32)
                            .padding(.horizontal, 16)
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(Color(UIColor(hex: "#3E5481")))
                                .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 0))
                            
                            Text("Search")
                                .font(.system(size: 15))
                                .foregroundColor(Color(UIColor(hex: "#9FA5C0")))
                                .fontWeight(.medium)
                            
                            Spacer()
                        }
                        .padding(.horizontal, 24)
                    }
                }
                
                // Category Chips Option
                HStack {
                    Text("Category")
                        .font(.system(size: 17))
                        .foregroundColor(Color(UIColor(hex: "#3E5481")))
                        .fontWeight(.bold)
                    Spacer()
                }
                .padding(16)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(options, id: \.self) { option in
                            Button(action: {
                                // Toggle the selected state of the option
                                if selectedOptions.contains(option) {
                                    selectedOptions.remove(option)
                                } else {
                                    selectedOptions.insert(option)
                                }
                            }) {
                                Text(option)
                                    .padding(EdgeInsets(top: 15, leading: 24, bottom: 15, trailing: 24))
                                    .foregroundColor(selectedOptions.contains(option) ? .white : Color(UIColor(hex: "#9FA5C0")))
                                    .background(selectedOptions.contains(option) ? Color(UIColor(hex: "#1FCC79")) : Color(UIColor(hex: "#F4F5F7")))
                                    .cornerRadius(32)
                                    .font(.system(size: 15))
                                    .fontWeight(.bold)
                            }
                        }
                        Spacer()
                    }
                    .padding(.horizontal, 16)
                }
                
                // Grid View of Recipes
                ScrollView {
                    LazyVGrid(columns: Array(repeating: GridItem(), count: 2), spacing: 16) {
                        ForEach(1...20, id: \.self) { item in
                            // Replace this with your actual grid item view
                            Rectangle()
                                .frame(height: 100)
                                .foregroundColor(.blue)
                        }
                    }
                    .padding(16)
                }
            }
        }
    }
}

#Preview {
    IRAHomeView()
}
