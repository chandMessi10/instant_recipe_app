//
//  IRACustomHeaderView.swift
//  InstantRecipeApp
//
//  Created by Suraj Chand on 23/02/2024.
//

import SwiftUI

struct IRACustomHeaderView: View {
    var headerTitle: String
    var headerSubTitle: String
    
    init(headerTitle: String, headerSubTitle: String) {
        self.headerTitle = headerTitle
        self.headerSubTitle = headerSubTitle
    }
    
    var body: some View {
        VStack {
            Text(headerTitle)
                .foregroundColor(Color(UIColor(hex: "#2E3E5C")))
                .font(.title)
                .fontWeight(.bold)
                .padding(.top)
            
            Text(headerSubTitle)
                .foregroundColor(Color(UIColor(hex: "#9FA5C0")))
                .font(.system(size: 15))
                .padding(.bottom, 32)
        }
    }
}

#Preview {
    IRACustomHeaderView(headerTitle: "Header Title", headerSubTitle: "Header Sub Title")
}
