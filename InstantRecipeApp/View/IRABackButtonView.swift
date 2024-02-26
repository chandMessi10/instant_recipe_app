//
//  IRABackButtonView.swift
//  InstantRecipeApp
//
//  Created by Suraj Chand on 24/02/2024.
//

import SwiftUI

struct IRABackButtonView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
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
