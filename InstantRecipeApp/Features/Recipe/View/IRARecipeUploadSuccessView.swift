//
//  IRARecipeUploadSuccessView.swift
//  InstantRecipeApp
//
//  Created by Suraj Chand on 26/07/2024.
//

import SwiftUI
import LinkNavigator

struct IRARecipeUploadSuccessView: View {
    let navigator: LinkNavigatorType
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "checkmark.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
                .foregroundColor(Color(UIColor(hex: "#1FCC79")))
            
            Text("Upload Success")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("Your recipe has been uploaded. You can see it in your profile")
                .font(.body)
                .multilineTextAlignment(.center)
            
            IRACustomButton(
                buttonText: "Back to Home"
            )
            {
                navigator.replace(paths: ["home"], items: [:], isAnimated: true)
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 24)
            .fill(Color.white)
            .shadow(color: .gray, radius: 10, x: 0, y: 5))
        .padding()
    }
}

//#Preview {
//    IRARecipeUploadSuccessView()
//}
