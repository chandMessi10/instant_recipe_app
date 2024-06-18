//
//  IRACustomButton.swift
//  InstantRecipeApp
//
//  Created by Suraj Chand on 25/02/2024.
//

import SwiftUI

struct IRACustomButton: View {
    var buttonText: String
    var action: (() async -> Void)?  // Action is async
    var isButtonDisabled: Bool = false
    var hasBorder: Bool = false
    var isSecondaryButton: Bool = false
    var isLoading: Bool = false  // Loading state
    
    init(
        buttonText: String,
        //        action: @escaping (() -> Void),
        action: (() async -> Void)? = nil,
        isButtonDisabled: Bool = false,
        hasBorder: Bool = false,
        isSecondaryButton: Bool = false,
        isLoading: Bool = false
    ) {
        self.buttonText = buttonText
        self.action = action
        self.isButtonDisabled = isButtonDisabled
        self.hasBorder = hasBorder
        self.isSecondaryButton = isSecondaryButton
        self.isLoading = isLoading
    }
    
    var body: some View {
        Button(
            action: {
                // Call async action using Task
                Task {
                    await action?()
                }
            },
            label: {
                ZStack {
                    if isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                    } else {
                        Text(buttonText)
                            .font(.system(size: 15))
                            .fontWeight(.bold)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(isSecondaryButton ?  Color(UIColor(hex: "#F4F5F7")) : (hasBorder ? Color.white : Color(UIColor(hex: "#1FCC79"))))
                .foregroundColor(isSecondaryButton ? Color(UIColor(hex: "#2E3E5C")) : (hasBorder ? Color(UIColor(hex: "#9FA5C0")) : Color.white))
                .cornerRadius(32)
                .overlay(
                    RoundedRectangle(cornerRadius: 32)
                        .stroke(hasBorder ? Color(UIColor(hex: "#D0DBEA")) : Color.clear, lineWidth: hasBorder ? 2 : 0)
                )
            }
        ).disabled(isButtonDisabled)
    }
}

#Preview {
    IRACustomButton(
        buttonText: "Test",
        action: {},
        isButtonDisabled: false,
        hasBorder: false,
        isSecondaryButton: true
    )
}
