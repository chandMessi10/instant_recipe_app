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
    
    var body: some View {
        VStack {
            Text("Recipe Detail Page")
        }
        .navigationBarItems(
            trailing: Button(
                action: {
                   
                },
                label: {
                    Image(systemName: "square.and.arrow.up")
                        .font(.title3)
                        .foregroundColor(.black)
                }
            )
        )
    }
}

//#Preview {
//    IRARecipeDetailView()
//}
