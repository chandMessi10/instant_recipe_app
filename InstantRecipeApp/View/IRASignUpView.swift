//
//  IRASignUpView.swift
//  InstantRecipeApp
//
//  Created by Suraj Chand on 23/02/2024.
//

import SwiftUI

struct IRASignUpView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            VStack {
                IRACustomHeaderView(
                    headerTitle: "Welcome",
                    headerSubTitle: "Please enter your account here"
                )
                
                IRACustomNavigationView(
                    destination: IRADashboardView(),
                    buttonText: "Sign Up",
                    action: {
//                        viewModel.login()
                    }
//                    isButtonDisabled: (viewModel.emailError != nil || viewModel.passwordError != nil)
                )
            }
        }
        .padding()
        .navigationBarBackButtonHidden()
        .navigationBarItems(leading: backButton)
    }
    
    var backButton: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "chevron.backward")
                .foregroundColor(Color(UIColor(hex: "#2E3E5C")))
                .padding()
        }
//        .symbolVariant(.circle.fill)
//        .font(.title)
    }
}

#Preview {
    IRASignUpView()
}
