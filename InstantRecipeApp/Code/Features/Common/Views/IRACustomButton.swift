//
//  IRACustomButton.swift
//  InstantRecipeApp
//
//  Created by Suraj Chand on 25/02/2024.
//

import SwiftUI

struct IRACustomButton: View {
    var buttonText: String
    var action: (() -> Void)
    var isButtonDisabled: Bool = false
    var hasBorder: Bool = false
    
    init(
        buttonText: String,
        action: @escaping (() -> Void),
        isButtonDisabled: Bool = false,
        hasBorder: Bool = false
    ) {
        self.buttonText = buttonText
        self.action = action
        self.isButtonDisabled = isButtonDisabled
        self.hasBorder = hasBorder
    }
    
    var body: some View {
        Button(
            action: {
                action() // Call the action closure
            },
            label: {
                Text(buttonText)
                    .font(.system(size: 15))
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(hasBorder ? Color.white : Color(UIColor(hex: "#1FCC79")))
                    .foregroundColor(hasBorder ? Color(UIColor(hex: "#9FA5C0")) : Color.white)
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
        hasBorder: true
    )
}
