//
//  IRALogInViewModel.swift
//  InstantRecipeApp
//
//  Created by Suraj Chand on 21/02/2024.
//

import Foundation

class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    
    @Published var emailError: String? = nil
    @Published var passwordError: String? = nil
    
    func validateEmail() {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        emailError = predicate.evaluate(with: email) ? nil : "Invalid email format"
    }
    
    func validatePassword() {
        let passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[a-zA-Z\\d!@#$%^&*]{8,}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        passwordError = predicate.evaluate(with: password) ? nil : "Password must be at least 8 characters with a mix of uppercase, lowercase, and numbers"
    }
    
    func login() {
        // Replace with your actual login logic
        // Check if email and password are valid based on validation errors
        if emailError == nil && passwordError == nil {
            // Perform login attempt and handle response
        }
    }
}
