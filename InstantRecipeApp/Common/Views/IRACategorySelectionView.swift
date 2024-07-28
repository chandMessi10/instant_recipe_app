//
//  IRACategorySelectionView.swift
//  InstantRecipeApp
//
//  Created by Suraj Chand on 26/07/2024.
//

import SwiftUI

struct IRACategorySelectionView: View {
    @Binding var selectedOptions: Set<String>
    let options: [String]
    let isMultiSelection: Bool
    
    var body: some View {
        Group {
            HStack {
                Text("Category")
                    .font(.system(size: 17))
                    .foregroundColor(Color(UIColor(hex: "#3E5481")))
                    .fontWeight(.bold)
                Spacer()
            }
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(options, id: \.self) { option in
                        Button(action: {
                            toggleSelection(for: option)
                        }) {
                            Text(option)
                                .padding(EdgeInsets(top: 15, leading: 24, bottom: 15, trailing: 24))
                                .foregroundColor(selectedOptions.contains(option) ? .white : Color(UIColor(hex: "#9FA5C0")))
                                .background(selectedOptions.contains(option) ? Color(UIColor(hex: "#1FCC79")) : Color(UIColor(hex: "#F4F5F7")))
                                .cornerRadius(32)
                                .font(.system(size: 15))
                                .fontWeight(.bold)
                        }
                    }
                    Spacer()
                }
            }
        }
    }
    
    private func toggleSelection(for option: String) {
        if isMultiSelection {
            if selectedOptions.contains(option) {
                selectedOptions.remove(option)
            } else {
                selectedOptions.insert(option)
            }
        } else {
            selectedOptions = [option]
        }
    }
}
