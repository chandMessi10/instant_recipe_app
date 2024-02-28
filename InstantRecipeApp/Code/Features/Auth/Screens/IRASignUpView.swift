//
//  IRASignUpView.swift
//  InstantRecipeApp
//
//  Created by Suraj Chand on 23/02/2024.
//

import SwiftUI

struct IRASignUpView: View {
    @StateObject var viewModel: IRAAuthViewModel
    @State private var isPasswordVisible = false
    
    init() {
        self._viewModel = StateObject(wrappedValue: IRAAuthViewModel())
    }
    
    var body: some View {
//        NavigationView {
            VStack {
                IRACustomHeaderView(
                    headerTitle: "Welcome",
                    headerSubTitle: "Please enter your account here"
                )
                
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
                .padding(.vertical, 8)
                
                IRACustomTextFieldView(
                    prefixImage: "lock.fill",
                    textFieldLabel: "Password",
                    isPasswordField: true,
                    errorText: $viewModel.passwordError,
                    fieldText: $viewModel.password
                )
                .padding(.vertical, 8)
                
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
                
                IRACustomNavigationView(
                    destination: IRADashboardView(),
                    buttonText: "Sign Up",
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
    IRASignUpView()
}

