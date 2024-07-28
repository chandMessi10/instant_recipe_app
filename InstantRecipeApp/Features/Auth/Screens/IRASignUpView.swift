//
//  IRASignUpView.swift
//  InstantRecipeApp
//
//  Created by Suraj Chand on 23/02/2024.
//

import SwiftUI

struct IRASignUpView: View {
    @StateObject var viewModel: IRAAuthViewModel
    
    init() {
        self._viewModel = StateObject(wrappedValue: IRAAuthViewModel())
    }
    
    @FocusState private var focusedField: FocusElement?
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack {
                    IRACustomHeaderView(
                        headerTitle: "Welcome",
                        headerSubTitle: "Please enter your account here"
                    )
                    
                    IRACustomTextFieldView(
                        prefixImage: "person.fill",
                        textFieldLabel: "Name",
                        isError: viewModel.nameError == "" ? false : true,
                        errorText: $viewModel.nameError,
                        fieldText: $viewModel.name,
                        submitLabel: .next,
                        onSubmit: {
                            focusedField = .email
                        }
                    )
                    .onChange(of: $viewModel.name.wrappedValue) { _, _ in
                        viewModel.validateName()
                    }
                    .focused($focusedField, equals: .name)
                    .padding(.vertical, 8)
                    
                    IRACustomTextFieldView(
                        prefixImage: "envelope.fill",
                        textFieldLabel: "Email",
                        isError: viewModel.emailError == "" ? false : true,
                        errorText: $viewModel.emailError,
                        fieldText: $viewModel.email,
                        submitLabel: .next,
                        onSubmit: {
                            focusedField = .password
                        },
                        keyboardType: .emailAddress
                    )
                    .onChange(of: $viewModel.email.wrappedValue) { _, _ in
                        viewModel.validateEmail()
                    }
                    .focused($focusedField, equals: .email)
                    .padding(.vertical, 8)
                    
                    IRACustomTextFieldView(
                        prefixImage: "lock.fill",
                        textFieldLabel: "Password",
                        isPasswordField: true,
                        isError: viewModel.passwordError == "" ? false : true,
                        errorText: $viewModel.passwordError,
                        fieldText: $viewModel.password,
                        submitLabel: .done,
                        onSubmit: {
                            // call signup method
                        }
                    )
                    .focused($focusedField, equals: .password)
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
                    
                    IRACustomButton(
                        buttonText: "Sign Up",
                        action: {
                            await viewModel.signUpUser()
                        },
                        isLoading: viewModel.signUpState == .loading
                    )
                }
                .padding()
            }
            
            if viewModel.signUpState == .error || viewModel.signUpState == .success {
                ToastView(
                    message: $viewModel.apiResponseValue.wrappedValue
//                    type: $viewModel.apiToastType.wrappedValue
                )
                    .zIndex(1)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation {
                                viewModel.signUpState = .initial // Hide the toast after 2 seconds
                            }
                        }
                    }
                    .onTapGesture {
                        withAnimation {
                            viewModel.signUpState = .initial // Hide the toast when tapped
                        }
                    }
            }
        }
    }
}

#Preview {
    IRASignUpView()
}
