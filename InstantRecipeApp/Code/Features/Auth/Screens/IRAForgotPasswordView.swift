//
//  IRAForgotPasswordView.swift
//  InstantRecipeApp
//
//  Created by Suraj Chand on 23/02/2024.
//

import SwiftUI

struct IRAForgotPasswordView: View {
    @StateObject var viewModel: IRAAuthViewModel
    
    init() {
        self._viewModel = StateObject(wrappedValue: IRAAuthViewModel())
    }
    
    var body: some View {
//        NavigationView {
            VStack {
                IRACustomHeaderView(
                    headerTitle: "Password recovery",
                    headerSubTitle: "Enter your email address to recover your password"
                )
                .padding(.bottom, 32)
                
                IRACustomTextFieldView(
                    prefixImage: "envelope.fill",
                    textFieldLabel: "Email",
                    isError: viewModel.emailError == "" ? false : true,
                    errorText: $viewModel.emailError,
                    fieldText: $viewModel.email
                )
                .onChange(of: $viewModel.email.wrappedValue) { _, _ in
                    viewModel.validateEmail()
                }
                .padding(.bottom, 32)
                
                IRACustomNavigationView(
                    destination: IRAResetPasswordView(),
                    buttonText: "Continue",
                    action: {
                        
                    }
                )
                Spacer()
            }
            .padding()
//            .navigationBarItems(leading: IRABackButtonView())
//        }
//        .navigationBarBackButtonHidden()
    }
}

#Preview {
    IRAForgotPasswordView()
}
