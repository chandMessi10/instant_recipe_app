//
//  IRACustomTextFieldView.swift
//  InstantRecipeApp
//
//  Created by Suraj Chand on 23/02/2024.
//

import SwiftUI

struct IRACustomTextFieldView: View {
    var prefixImage: String
    var textFieldLabel: String
    var isPasswordField: Bool = false
    var isError: Bool = false
    @Binding var errorText: String
    @Binding var formTextField: String
    var submitLabel: SubmitLabel = .done
    var onSubmit: (() -> Void)?
    var keyboardType: UIKeyboardType

    init(
        prefixImage: String,
        textFieldLabel: String,
        isPasswordField: Bool = false,
        isError: Bool = false,
        errorText: Binding<String>,
        fieldText: Binding<String>,
        submitLabel: SubmitLabel = .done,
        onSubmit: (() -> Void)? = nil,
        keyboardType: UIKeyboardType = .default
    ) {
        self.prefixImage = prefixImage
        self.textFieldLabel = textFieldLabel
        self.isPasswordField = isPasswordField
        self.isError = isError
        self._errorText = errorText
        self._formTextField = fieldText
        self.submitLabel = submitLabel
        self.onSubmit = onSubmit
        self.keyboardType = keyboardType
    }
    
    @State private var isPasswordVisible = false
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: prefixImage)
                    .foregroundColor(Color(UIColor(hex: "#2E3E5C")))
                
                if isPasswordField {
                    if isPasswordVisible {
                        TextField(textFieldLabel, text: $formTextField)
                            .submitLabel(submitLabel)
                            .onSubmit {
                                onSubmit?()
                            }
                            .keyboardType(keyboardType)
                    } else {
                        SecureField(textFieldLabel, text: $formTextField)
                            .submitLabel(submitLabel)
                            .onSubmit {
                                onSubmit?()
                            }
                            .keyboardType(keyboardType)
                    }
                    
                    Button(action: {
                        isPasswordVisible.toggle()
                    }) {
                        Image(systemName: isPasswordVisible ? "eye.slash.fill" : "eye.fill")
                            .foregroundColor(Color(UIColor(hex: "#2E3E5C")))
                    }
                } else {
                    TextField(textFieldLabel, text: $formTextField)
                        .submitLabel(submitLabel)
                        .onSubmit {
                            onSubmit?()
                        }
                        .keyboardType(keyboardType)
                }
            }
            .padding(16)
            .overlay(
                RoundedRectangle(cornerRadius: 32)
                    .stroke(Color(UIColor(hex: isError ? "#FF6464" : "#D0DBEA")), lineWidth: 2)
            )
            if isError {
                Text(errorText)
                    .font(.caption)
                    .foregroundColor(Color(UIColor(hex: "#FF6464")))
                    .padding(.horizontal, 18)
                    .padding(.vertical, 4)
            }
        }
    }
}

struct IRACustomTextFieldView_Previews: PreviewProvider {
    @State static var email: String = ""
    @State static var emailError: String = ""
    
    static var previews: some View {
        IRACustomTextFieldView(
            prefixImage: "envelope.fill",
            textFieldLabel: "Label",
            isPasswordField: false,
            isError: false,
            errorText: $emailError,
            fieldText: $email
        )
        .padding()
    }
}

//#Preview {
//    @State var email: String = ""
//    
//    IRACustomTextFieldView(
//        prefixImage: "envelope.fill",
//        textFieldLabel: "Label",
//        isPasswordField: false,
//        isError: false,
//        errorText: "Error message",
//        fieldText: $email
//    )
//    .padding()
//}
