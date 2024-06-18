//
//  IRALoginView.swift
//  InstantRecipeApp
//
//  Created by Suraj Chand on 21/02/2024.
//

import SwiftUI

struct IRASignInView: View {
    @StateObject var viewModel: IRAAuthViewModel
    @State private var isPasswordVisible = false
    
    init() {
        self._viewModel = StateObject(wrappedValue: IRAAuthViewModel())
    }
    
    var body: some View {
            ScrollView {
                VStack(alignment: .center) {
                    // Circle with the logo at the center
                    Circle()
                        .fill( Color(UIColor(hex: "#1FCC79"))) // Background color of the circle
                        .frame(width: 150, height: 150) // Size of the circle
                        .overlay(
                            Image(systemName: "fork.knife.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 75, height: 75)
                        )
                    Spacer()
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
                    .padding(.vertical, 8)
                    .onChange(of: $viewModel.email.wrappedValue) { _, _ in
                        viewModel.validateEmail()
                    }
                    
                    IRACustomTextFieldView(
                        prefixImage: "lock.fill",
                        textFieldLabel: "Password",
                        isPasswordField: true,
                        isError: viewModel.passwordError == "" ? false : true,
                        errorText: $viewModel.passwordError,
                        fieldText: $viewModel.password
                    )
                    .padding(.vertical, 8)
                    .onChange(of: $viewModel.password.wrappedValue) { _, _ in
                        viewModel.validateSignInPassword()
                    }
                    
                    HStack {
                        Spacer()
                        NavigationLink(
                            destination: IRAForgotPasswordView()
                        ) {
                            Text("Forgot Password?")
                                .foregroundColor(Color(UIColor(hex: "#9FA5C0")))
                                .font(.headline)
                        }
                        .padding(.vertical, 16)
                    }
                    .padding(.bottom, 16)
                    
                    IRACustomNavigationView(
                        destination: IRADashboardView(),
                        buttonText: "Login",
                        action: {
                            
                        },
                        isButtonDisabled: (viewModel.emailError != "" || viewModel.passwordError != "")
                    )
                    
                    NavigationLink(
                        destination: IRASignUpView()
                    ) {
                        HStack {
                            Text("Don't have an account?")
                                .foregroundColor(Color(UIColor(hex: "#9FA5C0")))
                                .font(.headline)
                                .fontWeight(.semibold)
                            Text("Sign Up")
                                .foregroundColor(Color(UIColor(hex: "#24D37F")))
                                .font(.headline)
                                .fontWeight(.bold)
                        }
                    }
                    .isDetailLink(false)
                    .padding(.vertical, 36)
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background {
                    Color.white
                        .ignoresSafeArea()
                }
            }
    }
}

#Preview {
    IRASignInView()
}