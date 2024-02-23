//
//  IRALoginView.swift
//  InstantRecipeApp
//
//  Created by Suraj Chand on 21/02/2024.
//

import SwiftUI

struct IRASignInView: View {
    @StateObject var viewModel: IRASignInViewModel
    @State private var isPasswordVisible = false
    
    init() {
        self._viewModel = StateObject(wrappedValue: IRASignInViewModel())
    }
    
    var body: some View {
        NavigationView {
            VStack {
                IRACustomHeaderView(
                    headerTitle: "Welcome Back!",
                    headerSubTitle: "Please enter your account here"
                )
                
                IRACustomTextFieldView(
                    prefixImage: "envelope.fill",
                    textFieldLabel: "Email",
                    isError: false,
                    fieldText: $viewModel.email
                ).padding(.vertical, 8)
                
                IRACustomTextFieldView(
                    prefixImage: "lock.fill",
                    textFieldLabel: "Password",
                    isPasswordField: true,
                    isError: false,
                    fieldText: $viewModel.password
                ).padding(.vertical, 8)
                
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
                        viewModel.login()
                    },
                    isButtonDisabled: (viewModel.emailError != nil || viewModel.passwordError != nil)
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
                .padding(.vertical, 36)
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background {
                Color.white
                    .ignoresSafeArea()
            }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    IRASignInView()
}

extension UIColor {
    convenience init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        
        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
