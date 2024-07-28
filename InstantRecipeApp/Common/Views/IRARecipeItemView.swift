//
//  IRARecipeItemView.swift
//  InstantRecipeApp
//
//  Created by Suraj Chand on 25/07/2024.
//

import SwiftUI

struct IRARecipeItemView: View {
    var recipeImageId: String
    var foodName: String
    var foodCategory: String
    var time: Int
    var onTap: () -> Void
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack(alignment: .leading) {
                if recipeImageId.isEmpty {
                    Image(systemName: "fork.knife.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 180, maxHeight: 160)
                        .background(Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(16)
                } else {
                    AsyncImage(
                        url: URL(string: "https://cloud.appwrite.io/v1/storage/buckets/6675b9630033239a91e6/files/\(recipeImageId)/view?project=666d6bec0028d0c01b84")!,
                        scale: 4
                    ) { phase in
                        if let image = phase.image {
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(maxWidth: 180, maxHeight: 160)
                                .background(Color.gray)
                                .foregroundColor(.white)
                                .cornerRadius(16)
                        } else if phase.error != nil {
                            // You can show an error view here if needed
                            Text("Failed")
                                .frame(maxWidth: 180, maxHeight: 160)
                                .background(Color.gray)
                                .foregroundColor(.white)
                                .cornerRadius(16)
                        } else {
                            // Placeholder while loading
                            ProgressView()
                                .frame(maxWidth: 180, maxHeight: 160)
                                .background(Color.gray)
                                .foregroundColor(.white)
                                .cornerRadius(16)
                        }
                    }
                }
                
                Text(foodName)
                    .font(.system(size: 14))
                    .fontWeight(.bold)
                    .foregroundColor(Color(UIColor(hex: "#3E5481")))
                
                HStack {
                    Text(foodCategory)
                        .font(.system(size: 10))
                        .fontWeight(.medium)
                        .foregroundColor(Color(UIColor(hex: "#9FA5C0")))
                    Circle()
                        .frame(width: 5, height: 5)
                        .foregroundColor(Color(UIColor(hex: "#9FA5C0")))
                    Text("\(time) min")
                        .font(.system(size: 12))
                        .fontWeight(.medium)
                        .foregroundColor(Color(UIColor(hex: "#9FA5C0")))
                }
            }
            .onTapGesture {
                onTap()
            }
            
            // Hide favorite button for now
            /*
             Button(
             action: {
             // Add favorite action here
             },
             label: {
             ZStack {
             Rectangle()
             .foregroundColor(.white).opacity(0.3)
             .frame(width: 32, height: 32)
             .cornerRadius(8)
             
             Image(systemName: "heart")
             .foregroundColor(.white)
             .font(.system(size: 20))
             }
             .padding(8)
             .offset(x: -2, y: 2)
             }
             )
             */
        }
        .frame(height: 230)
        .padding(.bottom, 2)
    }
}

#Preview {
    IRARecipeItemView(
        recipeImageId: "https://avatars.githubusercontent.com/u/30414962?v=4",
        foodName: "Food Name",
        foodCategory: "Food Details",
        time: 0,
        onTap: {
            // Your tap action here
            print("Recipe item tapped!")
        }
    )
}
