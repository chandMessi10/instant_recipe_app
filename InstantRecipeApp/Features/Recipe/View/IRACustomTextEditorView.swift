//
//  IRACustomTextEditorView.swift
//  InstantRecipeApp
//
//  Created by Suraj Chand on 26/07/2024.
//

import SwiftUI

struct IRACustomTextEditorView: View {
    var textFieldLabel: String
    var isError: Bool = false
    @Binding var errorText: String
    @Binding var formTextField: String
    
    init(
        textFieldLabel: String,
        isError: Bool = false,
        errorText: Binding<String>,
        fieldText: Binding<String>
    ) {
        self.textFieldLabel = textFieldLabel
        self.isError = isError
        self._errorText = errorText
        self._formTextField = fieldText
    }
    
    var body: some View {
        ZStack {
//            if formTextField == "" {
//                Text("oi hughie")
//                    .foregroundColor(Color.black)
//            }
            
            TextEditor(text: $formTextField)
                .frame(minHeight: 46, maxHeight: 5 * 30)
                .padding(EdgeInsets(top: 8, leading: 10, bottom: 0, trailing: 10))
        }
        
        .background(Color(UIColor.systemBackground))
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
