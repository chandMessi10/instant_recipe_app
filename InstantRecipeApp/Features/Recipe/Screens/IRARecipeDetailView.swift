//
//  IRARecipeDetailView.swift
//  InstantRecipeApp
//
//  Created by Suraj Chand on 25/07/2024.
//

import SwiftUI
import LinkNavigator

struct IRARecipeDetailView: View {
    let navigator: LinkNavigatorType
    @StateObject var viewModel: IRARecipeDetailViewModel
    @State var recipeName : String = ""
    @State var recipeImageId : String = ""
    @State var recipeDescription : String = ""
    @State var recipeCategory : String = ""
    @State var recipeCookingTime : String = ""
    @State var chefName : String = ""
    
    init(
        navigator: LinkNavigatorType,
        recipeName: String,
        recipeImageId: String,
        recipeDescription: String,
        recipeCategory: String,
        recipeCookingTime: String,
        chefName: String
    ) {
        self._viewModel = StateObject(wrappedValue: IRARecipeDetailViewModel())
        self.navigator = navigator
        _recipeName = State(initialValue: recipeName)
        _recipeImageId = State(initialValue: recipeImageId)
        _recipeDescription = State(initialValue: recipeDescription)
        _recipeCategory = State(initialValue: recipeCategory)
        _recipeCookingTime = State(initialValue: recipeCookingTime)
        _chefName = State(initialValue: chefName)
    }
    
    var body: some View {
        ScrollView {
            VStack {
                if recipeImageId.isEmpty {
                    Image(systemName: "fork.knife.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity, maxHeight: 160)
                        .background(Color.gray)
                        .foregroundColor(.white)
                } else {
                    AsyncImage(
                        url: URL(string: "https://cloud.appwrite.io/v1/storage/buckets/6675b9630033239a91e6/files/\(recipeImageId)/view?project=666d6bec0028d0c01b84")!,
                        scale: 4
                    ) { phase in
                        if let image = phase.image {
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(maxWidth: .infinity, maxHeight: 300)
                                .background(Color.gray)
                                .foregroundColor(.white)
                                .clipped()
//                                .padding(.bottom, 16)
                        } else if phase.error != nil {
                            // You can show an error view here if needed
                            Text("Failed")
                                .frame(maxWidth: .infinity, maxHeight: 300)
                                .background(Color.gray)
                                .foregroundColor(.white)
//                                .padding(.bottom, 16)
                        } else {
                            // Placeholder while loading
                            ProgressView()
                                .frame(width: 100, height: 300)
                                .background(Color.white)
                                .foregroundColor(.white)
//                                .padding(.bottom, 16)
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: 300)
                    .clipped()
                }
                
                VStack(spacing: 0) {
                    Text("\(recipeName)")
                        .foregroundColor(Color(UIColor(hex: "#3E5481")))
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 4)
                    
                    HStack {
                        Text("\(recipeCategory)")
                            .font(.caption2)
                            .fontWeight(.medium)
                            .foregroundColor(Color(UIColor(hex: "#9FA5C0")))
                        Circle()
                            .frame(width: 6, height: 6)
                            .foregroundColor(Color(UIColor(hex: "#9FA5C0")))
                        Text("\(recipeCookingTime) mins")
                            .font(.caption2)
                            .fontWeight(.medium)
                            .foregroundColor(Color(UIColor(hex: "#9FA5C0")))
                        Spacer()
                    }
                    .padding(.bottom, 8)
                    
                    HStack {
                        Circle()
                            .frame(width: 24, height: 24)
                            .foregroundColor(Color(UIColor(hex: "#9FA5C0")))
                            .padding(0)
                        Text(" \(chefName)")
                            .font(.title3)
                            .fontWeight(.semibold)
                        Spacer()
                    }
                    .padding(.bottom, 4)
                    
                    Divider()
                        .padding(.bottom, 4)
                    
                    HStack {
                        Text("Description")
                            .font(.title2)
                            .fontWeight(.bold)
                        Spacer()
                    }
                    .padding(.bottom, 4)
                    
                    Text("\(recipeDescription)")
                        .font(.subheadline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Spacer()
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
            }
        }
        .ignoresSafeArea()
        //        .navigationBarItems(
        //            trailing: Button(
        //                action: {
        //
        //                },
        //                label: {
        //                    Image(systemName: "square.and.arrow.up")
        //                        .font(.title3)
        //                        .foregroundColor(.black)
        //                }
        //            )
        //        )
    }
}

struct ImageView: View {
    let image: UIImage?
    
    var body: some View {
        if let image = image {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 300)
        } else {
            Text("No Image Available")
        }
    }
}

//#Preview {
//    IRARecipeDetailView()
//}
