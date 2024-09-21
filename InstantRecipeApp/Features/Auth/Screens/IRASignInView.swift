//
//  IRALoginView.swift
//  InstantRecipeApp
//
//  Created by Suraj Chand on 21/02/2024.
//

import SwiftUI
import LinkNavigator

struct IRASignInView: View {
    let navigator: LinkNavigatorType
    @StateObject var viewModel: IRAAuthViewModel
    @State private var isPasswordVisible = false
    
    init(navigator: LinkNavigatorType) {
        self._viewModel = StateObject(wrappedValue: IRAAuthViewModel())
        self.navigator = navigator
    }
    
    @FocusState private var focusedField: FocusElement?
    
    // AppStorage property to keep appwrite session id
    @AppStorage("appwriteSessionID") var appwriteSessionID: String = ""
    
    var body: some View {
        ZStack {
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
                        fieldText: $viewModel.email,
                        submitLabel: .next,
                        onSubmit: {
                            focusedField = .password
                        },
                        keyboardType: .emailAddress
                    )
                    .padding(.vertical, 8)
                    .onChange(of: $viewModel.email.wrappedValue) { _, _ in
                        viewModel.validateEmail()
                    }
                    .focused($focusedField, equals: .email)
                    
                    IRACustomTextFieldView(
                        prefixImage: "lock.fill",
                        textFieldLabel: "Password",
                        isPasswordField: true,
                        isError: viewModel.passwordError == "" ? false : true,
                        errorText: $viewModel.passwordError,
                        fieldText: $viewModel.password,
                        submitLabel: .done,
                        onSubmit: {
                            // call sign in method
                        }
                    )
                    .padding(.vertical, 16)
                    .onChange(of: $viewModel.password.wrappedValue) { _, _ in
                        viewModel.validateSignInPassword()
                    }
                    .focused($focusedField, equals: .password)
                    
//                    HStack {
//                        Spacer()
//                        NavigationLink(
//                            destination: IRAForgotPasswordView()
//                        ) {
//                            Text("Forgot Password?")
//                                .foregroundColor(Color(UIColor(hex: "#9FA5C0")))
//                                .font(.headline)
//                        }
//                        .padding(.vertical, 16)
//                    }
//                    .padding(.bottom, 16)
                    
                    IRACustomButton(
                        buttonText: "Sign In",
                        action: {
                            await viewModel.signIn()
                        },
                        isLoading: viewModel.signInState == .loading
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
                .onChange(of: viewModel.currentDestination) { oldValue, newValue in
                    if newValue != nil  {
//                        appwriteSessionID = viewModel.sessionId
                        navigator.replace(paths: ["home"], items: [:], isAnimated: true)
                    }
                }
            }
            
            if viewModel.signInState == .error {
                ToastView(
                    message: $viewModel.apiResponseValue.wrappedValue
//                    type: $viewModel.apiToastType.wrappedValue
                )
                    .zIndex(1)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation {
                                viewModel.signInState = .initial // Hide the toast after 2 seconds
                            }
                        }
                    }
                    .onTapGesture {
                        withAnimation {
                            viewModel.signInState = .initial // Hide the toast when tapped
                        }
                    }
            }
        }
    }
}

//#Preview {
//    IRASignInView()
//}
