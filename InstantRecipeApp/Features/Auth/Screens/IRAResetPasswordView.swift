//
//  IRAResetPasswordView.swift
//  InstantRecipeApp
//
//  Created by Suraj Chand on 27/02/2024.
//

import SwiftUI

struct IRAResetPasswordView: View {
    @StateObject var viewModel: IRAAuthViewModel
    @State private var isPasswordVisible = false
    
    init() {
        self._viewModel = StateObject(wrappedValue: IRAAuthViewModel())
    }
    
    var body: some View {
        VStack {
            IRACustomHeaderView(
                headerTitle: "Reset your password",
                headerSubTitle: "Please enter your new password"
            )
            .padding(.bottom, 24)
            
            IRACustomTextFieldView(
                prefixImage: "lock.fill",
                textFieldLabel: "Password",
                isPasswordField: true,
                errorText: $viewModel.passwordError,
                fieldText: $viewModel.password
            )
            .padding(.bottom, 24)
            
            HStack {
                Text("Your password must contain: ")
                    .font(.system(size: 17))
                    .foregroundColor(Color(UIColor(hex: "#3E5481")))
                    .padding(.top, 24)
                    .fontWeight(.medium)
                Spacer()
            }
            .padding(.bottom, 16)
            
            IRAPasswordCriteriaListView(secureFieldText: $viewModel.password)
                .padding(.bottom, 24)
            
            IRACustomButton(buttonText: "Submit") {
                
            }
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    IRAResetPasswordView()
}
