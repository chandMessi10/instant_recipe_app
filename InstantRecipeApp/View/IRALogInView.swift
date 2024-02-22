//
//  IRALoginView.swift
//  InstantRecipeApp
//
//  Created by Suraj Chand on 21/02/2024.
//

import SwiftUI

struct IRALoginView: View {
    @StateObject var viewModel: LoginViewModel
    @State private var isPasswordVisible = false
    
    init() {
        self._viewModel = StateObject(wrappedValue: LoginViewModel())
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Welcome Back!")
                    .foregroundColor(Color(UIColor(hex: "#2E3E5C")))
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top)
                
                Text("Please enter your account here")
                    .foregroundColor(Color(UIColor(hex: "#9FA5C0")))
                    .font(.system(size: 15))
                    .padding(.bottom, 32)
                
                HStack {
                    Image(systemName: "envelope")
                        .foregroundColor(.gray)
                    TextField("Enter email", text: $viewModel.email)
                }
                .padding(16)
                .overlay(
                    RoundedRectangle(cornerRadius: 32)
                        .stroke(Color(UIColor(hex: "#D0DBEA")), lineWidth: 1)
                )
                
                HStack {
                    Image(systemName: "lock")
                        .foregroundColor(.gray)
                    if isPasswordVisible {
                        TextField("Enter password", text: $viewModel.password)
                    } else {
                        SecureField("Enter password", text: $viewModel.password)
                    }
                    
                    Button(action: {
                        isPasswordVisible.toggle()
                    }) {
                        Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                            .foregroundColor(.gray)
                    }
                }
                .padding(16)
                .overlay(
                    RoundedRectangle(cornerRadius: 32)
                        .stroke(Color(UIColor(hex: "#D0DBEA")), lineWidth: 1)
                ).padding(.vertical, 16)
                
                HStack {
                    Spacer() // Pushes the button to the rightmost side
                    Button(action: {
                        // Your button action code here
                        print("Button tapped")
                    }) {
                        Text("Forgot Password?")
                            .foregroundColor(Color(UIColor(hex: "#9FA5C0")))
                            .font(.headline)
                    }
                    .padding()
                }
                
                Button(action: {
                    viewModel.login()
                }) {
                    Text("Login")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(UIColor(hex: "#1FCC79")))
                        .foregroundColor(.white)
                        .cornerRadius(32)
                        .disabled(viewModel.emailError != nil || viewModel.passwordError != nil)
                }
                .padding(.top, 24)
                
                Button(action: {
                    // Your button action code here
                    print("Button tapped")
                }) {
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
                .padding(.vertical, 32)
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
    IRALoginView()
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
