//
//  IRALogInViewModel.swift
//  InstantRecipeApp
//
//  Created by Suraj Chand on 21/02/2024.
//

import Foundation

class IRAAuthViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    
    @Published var emailError: String = ""
    @Published var passwordError: String = ""
    
    func validateEmail() {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        if email.isEmpty {
            emailError = "Please enter an email"
        } else {
            emailError = predicate.evaluate(with: email) ? "" : "Invalid email format"
        }
    }
    
    func validateSignInPassword() {
        let passwordLength = password.count
        if password.isEmpty {
            passwordError = "Please enter password"
        } else {
            passwordError = (passwordLength >= 8) ? "" : "Password must be at least 8 characters"
        }
    }
    
    
    
    func validatePassword() {
        let passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[a-zA-Z\\d!@#$%^&*]{8,}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        passwordError = predicate.evaluate(with: password) ? "" : "Password must be at least 8 characters with a mix of uppercase, lowercase, and numbers"
    }
    
    func login() {
        // Replace with your actual login logic
        // Check if email and password are valid based on validation errors
        if emailError == "" && passwordError == ""{
            // Perform login attempt and handle response
        }
    }
}
