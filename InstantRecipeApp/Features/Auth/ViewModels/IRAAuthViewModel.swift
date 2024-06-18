//
//  IRALogInViewModel.swift
//  InstantRecipeApp
//
//  Created by Suraj Chand on 21/02/2024.
//

import Foundation
import Appwrite

class IRAAuthViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    
    @Published var nameError: String = ""
    @Published var emailError: String = ""
    @Published var passwordError: String = ""
    
    private var client: Client
    private var account: Account
    
    @Published var signUpState: APIState = .initial
    @Published var apiResponseValue: String = ""
    @Published var apiToastType: ToastType = ToastType.idle
    
    init() {
        self.client = ClientManager.shared.client
        self.account = Account(self.client)
    }
    
    func validateName() {
        // Regular expression to allow names with letters, spaces, hyphens, and apostrophes
        let nameRegex = "^[A-Za-z\\s'-]+$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", nameRegex)
        
        if name.isEmpty {
            nameError = "Please enter a name"
        } else {
            nameError = predicate.evaluate(with: name) ? "" : "Invalid name format"
        }
    }
    
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
    
    func validateSignUpPassword() {
        let passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[a-zA-Z\\d!@#$%^&*]{8,}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        passwordError = predicate.evaluate(with: password) ? "" : "Password must be at least 8 characters with a mix of uppercase, lowercase, and numbers"
    }
    
    func signIn() {
        if emailError == "" && passwordError == ""{
            
        }
    }
    
    func validateAllFields() {
        DispatchQueue.main.async {
            self.validateName()
            self.validateEmail()
            self.validateSignUpPassword()
        }
    }
    
    func signUpUser() async {
        if (name != "" && nameError == "") && (email != "" && emailError == "") && (password != "" && passwordError == "") {
            DispatchQueue.main.async {
                self.signUpState = .loading
            }
            do {
                let user = try await account.create(
                    userId: Appwrite.ID.unique(),
                    email: email,
                    password: password,
                    name: name
                )
                DispatchQueue.main.async {
                    self.signUpState = .success
                    print("account create success: \(user)")
                    self.apiResponseValue = "Account created successfully 😃"
                    self.apiToastType = ToastType.success
                }
            } catch let error as AppwriteError {
                // Handle AppwriteException
                print("Appwrite exception: \(error)")
                DispatchQueue.main.async {
                    self.signUpState = .error
                    self.apiResponseValue = error.description
                    self.apiToastType = ToastType.error
                }
            } catch {
                // Handle other generic exceptions
                print("Generic exception: \(error)")
                DispatchQueue.main.async {
                    self.signUpState = .error
                    self.apiResponseValue = error.localizedDescription
                    self.apiToastType = ToastType.error
                }
            }
        } else {
            validateAllFields()
        }
    }
}
