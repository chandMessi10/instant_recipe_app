//
//  IRABackButtonView.swift
//  InstantRecipeApp
//
//  Created by Suraj Chand on 24/02/2024.
//

import SwiftUI
import UIPilot

struct IRABackButtonView: View {
    @Environment(\.presentationMode) var presentationModer
    @EnvironmentObject var pilot: UIPilot<AppRoute>
    
    var body: some View {
        Button(action: {
            pilot.pop(animated: true)
//            presentationModer.wrappedValue.dismiss()
        }) {
            Image(systemName: "chevron.backward")
                .foregroundColor(Color(UIColor(hex: "#2E3E5C")))
                .padding(4)
        }
    }
}

#Preview {
    IRABackButtonView()
}
