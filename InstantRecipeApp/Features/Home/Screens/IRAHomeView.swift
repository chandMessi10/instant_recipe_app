//
//  IRAHomeView.swift
//  InstantRecipeApp
//
//  Created by Suraj Chand on 23/02/2024.
//

import SwiftUI
import LinkNavigator

struct IRAHomeView: View {
    let navigator: LinkNavigatorType
    @StateObject var viewModel: IRAHomeViewModel
    @State private var selectedOptions: Set<String> = ["All"]
    let options = ["All", "Food", "Drink"]
    
    init(navigator: LinkNavigatorType) {
        self._viewModel = StateObject(wrappedValue: IRAHomeViewModel())
        self.navigator = navigator
    }
    
    let gridItems = Array(repeating: GridItem(spacing: 24), count: 2)
    
    var body: some View {
        VStack {
            HStack {
                ZStack {
                    Rectangle()
                        .foregroundColor(Color(UIColor(hex: "#F4F5F7")))
                        .frame(height: 56)
                        .cornerRadius(32)
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
                    .padding(.horizontal, 16)
                }
                .onTapGesture {
                    navigator.sheet(paths: ["search"], items: [:], isAnimated: true)
                }
                
                Button(action: {
                    navigator.next(paths: ["profile"], items: [:], isAnimated: true)
                }) {
                    Image(systemName: "person.crop.circle")
                        .imageScale(.large)
                        .foregroundColor(Color(UIColor(hex: "#3E5481")))
                        .padding(12)
                        .background(Color(UIColor(hex: "#F4F5F7")))
                        .clipShape(Circle())
                }
                .font(.title3)
                .padding(.horizontal, 10)
            }.padding(.horizontal, 16)
            Spacer()
            
            if viewModel.recipeListState == .loading {
                VStack {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .scaleEffect(1.5)
                        .padding(.bottom, 8)
                    Text("Loading recipes...")
                }
            }
            
            if viewModel.recipeListState == .success {
                VStack {
                    // Category Chips Option
                    HStack {
                        Text("Category")
                            .font(.system(size: 17))
                            .foregroundColor(Color(UIColor(hex: "#3E5481")))
                            .fontWeight(.bold)
                        Spacer()
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    
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
                    
                    ScrollView {
                        LazyVGrid(columns: gridItems) {
                            ForEach(viewModel.documentsList, id: \.id) { document in
                                // Extract data from the document
                                let imageId = document.data["recipeImageId"]?.value as? String ?? ""
                                let recipeName = document.data["recipeName"]?.value as? String ?? "N/A"
                                let recipeCategory = document.data["recipeCategory"]?.value as? String ?? "N/A"
                                let time = document.data["recipeCookingTime"]?.value as? Int ?? 0
                                
                                IRARecipeItemView(
                                    recipeImageId: imageId,
                                    foodName: recipeName,
                                    foodCategory: recipeCategory,
                                    time: time,
                                    onTap: {
                                        navigator.sheet(
                                            paths: ["recipeDetail"],
                                            items: [
                                                "recipeName": recipeName,
                                                "recipeImageId": imageId,
                                                "recipeCookingTime": "\(time)",
                                                "recipeDescription": document.data["recipeDescription"]?.value as? String ?? "N/A",
                                                "chefName": document.data["chefName"]?.value as? String ?? "N/A",
                                                "recipeCategory": recipeCategory
                                            ],
                                            isAnimated: true
                                        )
                                    }
                                )
                            }
                        }
                        .padding(.horizontal, 16)
                    }
                }
            }
            
            if viewModel.recipeListState == .error {
                VStack {
                    Text("Error loading recipes...")
                        .padding(.bottom, 8)
                    IRACustomButton(buttonText: "Retry") {
                        viewModel.callGetRecipes()
                    }
                }
            }
            Spacer()
        }
    }
}

//#Preview {
//    IRAHomeView()
//}
