//
//  IRAPasswordCriteriaListView.swift
//  InstantRecipeApp
//
//  Created by Suraj Chand on 27/02/2024.
//

import SwiftUI

struct IRAPasswordCriteriaListView: View {
    @Binding var secureFieldText: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            IRAPasswordCriteriaItemView(
                text: "At least 8 characters",
                isFulfilled: secureFieldText.count >= 8
            )
            IRAPasswordCriteriaItemView(
                text: "At least one uppercase letter",
                isFulfilled: secureFieldText.rangeOfCharacter(from: .uppercaseLetters) != nil
            )
            IRAPasswordCriteriaItemView(
                text: "At least one lowercase letter",
                isFulfilled: secureFieldText.rangeOfCharacter(from: .lowercaseLetters) != nil
            )
            IRAPasswordCriteriaItemView(
                text: "At least one number",
                isFulfilled: secureFieldText.rangeOfCharacter(from: .decimalDigits) != nil
            )
        }
    }
}
