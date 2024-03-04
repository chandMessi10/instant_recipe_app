//
//  IRAProfileImageView.swift
//  InstantRecipeApp
//
//  Created by Suraj Chand on 02/03/2024.
//

import SwiftUI

struct IRAProfileImageView: View {
    @State var imageUrl: String
    
    init(imageUrl: String) {
        self.imageUrl = imageUrl
    }
    
    var body: some View {
        if imageUrl.isEmpty {
            Image(systemName: "person.crop.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 100)
                .clipShape(Circle())
                .shadow(radius: 10)
        } else {
            AsyncImage(url: URL(string: imageUrl)!,scale: 3)
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
                .scaledToFit()
                .clipShape(Circle())
                .shadow(radius: 10)
        }
    }
}

#Preview {
    IRAProfileImageView(
        imageUrl: "https://avatars.githubusercontent.com/u/30414962?v=4"
    )
}
