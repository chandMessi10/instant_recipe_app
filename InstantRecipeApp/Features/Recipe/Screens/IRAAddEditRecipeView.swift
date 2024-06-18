//
//  IRAAddEditRecipeView.swift
//  InstantRecipeApp
//
//  Created by Suraj Chand on 05/03/2024.
//

import SwiftUI

struct IRAAddEditRecipeView: View {
    @State private var isTapped = false
    
    var body: some View {
        VStack(alignment: .leading,spacing: 24) {
            ZStack {
                Rectangle()
                    .strokeBorder(style: StrokeStyle(lineWidth: 2, dash: [8]))
                    .frame(height: 161)
                    .foregroundColor(Color(UIColor(hex: "#D0DBEA")))
                    .cornerRadius(12)
                
                VStack {
                    Image(systemName: "photo.badge.plus")
                        .font(.title)
                        .foregroundColor(Color(UIColor(hex: "#9FA5C0")))
                        .padding(.bottom, 8)
                    
                    Text("Add Cover Photo")
                        .font(.system(size: 15))
                        .fontWeight(.semibold)
                        .foregroundColor(Color(UIColor(hex: "#3E5481")))
                        .padding(.bottom, 8)
                    
                    Text("(upto 2 MB)")
                        .font(.system(size: 12))
                        .fontWeight(.medium)
                        .foregroundColor(Color(UIColor(hex: "#9FA5C0")))
                }
            }
            
            Text("Food Name")
                .font(.system(size: 17))
                .fontWeight(.semibold)
                .foregroundColor(Color(UIColor(hex: "#3E5481")))
        }
        .padding()
    }
}

#Preview {
    IRAAddEditRecipeView()
}
