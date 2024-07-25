//
//  IRARecipeItemView.swift
//  InstantRecipeApp
//
//  Created by Suraj Chand on 25/07/2024.
//

import SwiftUI

struct IRARecipeItemView: View {
    var imageUrl: String
    var foodName: String
    var details: String
    var time: String
    var onTap: () -> Void // Closure property for tap action
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack(alignment: .leading) {
                if imageUrl.isEmpty {
                    Image(systemName: "fork.knife.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 180, maxHeight: 160)
                        .background(Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(16)
                        .padding(.bottom, 16)
                } else {
                    AsyncImage(
                        url: URL(string: imageUrl)!,
                        scale: 2
                    )
                    .frame(maxWidth: 180, maxHeight: 160)
                    .background(Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(16)
                }
                
                Text(foodName)
                    .font(.system(size: 14))
                    .fontWeight(.bold)
                    .foregroundColor(Color(UIColor(hex: "#3E5481")))
                
                HStack {
                    Text(details)
                        .font(.system(size: 10))
                        .fontWeight(.medium)
                        .foregroundColor(Color(UIColor(hex: "#9FA5C0")))
                    Circle()
                        .frame(width: 5, height: 5)
                        .foregroundColor(Color(UIColor(hex: "#9FA5C0")))
                    Text(time)
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
        .padding(.bottom, 16)
    }
}

#Preview {
    IRARecipeItemView(
        imageUrl: "https://avatars.githubusercontent.com/u/30414962?v=4",
        foodName: "Food Name",
        details: "Food Details",
        time: ">60 mins",
        onTap: {
            // Your tap action here
            print("Recipe item tapped!")
        }
    )
}
