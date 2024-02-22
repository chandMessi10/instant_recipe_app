//
//  IRAWelcomView.swift
//  InstantRecipeApp
//
//  Created by Suraj Chand on 21/02/2024.
//

import SwiftUI

struct IRAOnboardingView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color.white
                    .ignoresSafeArea()
                VStack {
                    Image("Onboarding")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity)
                    Spacer()
                }
                VStack {
                    Spacer()
                    Text("Start Cooking")
                        .foregroundColor(Color(UIColor(hex: "#2E3E5C")))
                        .font(.title)
                        .fontWeight(.bold)
                        .padding()
                    
                    Text("Let's begin our community\nto cook better food")
                        .foregroundColor(Color(UIColor(hex: "#9FA5C0")))
                        .multilineTextAlignment(.center)
                        .font(.system(size: 17))
                        .fontWeight(.semibold)
                        .padding(.bottom, 72)
                    
                    NavigationLink(destination: IRALoginView()) {
                        Text("Get Started")
                            .font(.system(size: 15))
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(UIColor(hex: "#1FCC79")))
                            .foregroundColor(.white)
                            .cornerRadius(32)
                    }
                }
                .padding(.horizontal, 16)
            }
        }
    }
}

#Preview {
    IRAOnboardingView()
}
