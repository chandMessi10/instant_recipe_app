//
//  IRAPasswordCriteriaItemView.swift
//  InstantRecipeApp
//
//  Created by Suraj Chand on 27/02/2024.
//

import SwiftUI

struct IRAPasswordCriteriaItemView: View {
    var text: String
    var isFulfilled: Bool
    
    var body: some View {
        HStack {
            Image(systemName: isFulfilled ? "checkmark.circle.fill" : "xmark.circle.fill")
                .font(.system(size: 15))
                .fontWeight(.medium)
                .foregroundColor(isFulfilled ? .green : .red)
            Text(text).foregroundColor(Color(UIColor(hex: "#2E3E5C")))
            Spacer()
        }
    }
}

#Preview {
    IRAPasswordCriteriaItemView(text: "Password criteria", isFulfilled: false)
}
