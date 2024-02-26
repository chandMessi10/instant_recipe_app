//
//  IRASignUpView.swift
//  InstantRecipeApp
//
//  Created by Suraj Chand on 23/02/2024.
//

import SwiftUI

struct IRASignUpView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject var viewModel: IRAAuthViewModel
    @State private var isPasswordVisible = false
    
    init() {
        self._viewModel = StateObject(wrappedValue: IRAAuthViewModel())
    }
    
    var body: some View {
        NavigationView {
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
                
                PasswordRequirementsView(secureFieldText: $viewModel.password)
                    .padding(.bottom, 24)
                
                IRACustomNavigationView(
                    destination: IRADashboardView(),
                    buttonText: "Sign Up",
                    action: {
                        
                    }
                )
                
                Spacer()
            }
        }
        .padding()
        .navigationBarBackButtonHidden()
        .navigationBarItems(leading: IRABackButtonView())
    }
}

#Preview {
    IRASignUpView()
}

struct PasswordRequirementsView: View {
    @Binding var secureFieldText: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            PasswordRequirementView(
                text: "At least 8 characters",
                isFulfilled: secureFieldText.count >= 8
            )
            PasswordRequirementView(
                text: "At least one uppercase letter",
                isFulfilled: secureFieldText.rangeOfCharacter(from: .uppercaseLetters) != nil
            )
            PasswordRequirementView(
                text: "At least one lowercase letter",
                isFulfilled: secureFieldText.rangeOfCharacter(from: .lowercaseLetters) != nil
            )
            PasswordRequirementView(
                text: "At least one number",
                isFulfilled: secureFieldText.rangeOfCharacter(from: .decimalDigits) != nil
            )
        }
    }
}

struct PasswordRequirementView: View {
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
