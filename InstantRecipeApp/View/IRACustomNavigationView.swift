//
//  IRACustomNavigationView.swift
//  InstantRecipeApp
//
//  Created by Suraj Chand on 23/02/2024.
//

import SwiftUI

struct IRACustomNavigationView<Content: View>: View {
    var destination: Content
    var buttonText: String
    var action: (() -> Void)?
    var isButtonDisabled: Bool = false
    var hasBorder: Bool = false
    
    init(destination: Content, buttonText: String, action: (() -> Void)? = nil, isButtonDisabled: Bool = false, hasBorder: Bool = false) {
        self.destination = destination
        self.buttonText = buttonText
        self.action = action
        self.isButtonDisabled = isButtonDisabled
        self.hasBorder = hasBorder
    }
    
    var body: some View {
        NavigationLink(destination: destination) {
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
                .disabled(isButtonDisabled)
        }
        .onTapGesture {
            action?() // Call the action closure if it's not nil
        }
    }
}


#Preview {
    IRACustomNavigationView(
        destination: Text("Custom View Example"),
        buttonText: "Test",
        action: {},
        hasBorder: false
    )
}
