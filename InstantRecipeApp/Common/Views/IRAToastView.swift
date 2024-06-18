//
//  IRAToastView.swift
//  InstantRecipeApp
//
//  Created by Suraj Chand on 16/06/2024.
//

import Foundation

import SwiftUI

struct ToastView: View {
    let message: String
    let type: ToastType
    
    var body: some View {
        VStack {
            // Icon View
            Image(systemName: iconName)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: 200)
                .padding()
                .background(Color.black.opacity(0.75))
                .foregroundColor(.white)
                .cornerRadius(10)
            
            // Message Text
            Text(message)
                .multilineTextAlignment(.center) // Center-align the text
                .padding()
                .frame(maxWidth: .infinity) // Ensure the Text fills the width
                .background(Color.black.opacity(0.75))
                .foregroundColor(.white)
                .cornerRadius(10)
                .transition(.opacity)
        }
        .padding() // Add some padding around the entire VStack
    }
    
    private var iconName: String {
        switch type {
        case .success:
            return "checkmark.circle.fill" // SF Symbol for success
        case .error:
            return "xmark.circle.fill" // SF Symbol for error
        case .idle:
            return "nosign"
        }
    }
}
