//
//  IRAWelcomView.swift
//  InstantRecipeApp
//
//  Created by Suraj Chand on 21/02/2024.
//

import SwiftUI
import LinkNavigator

struct IRAOnboardingView: View {
    let navigator: LinkNavigatorType
    
    // AppStorage property to track onboarding completion
    @AppStorage("hasCompletedOnboarding") var hasCompletedOnboarding: Bool = false
    
    var body: some View {
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
                
                IRACustomButton(buttonText: "Continue") {
                    hasCompletedOnboarding = true
                    navigator.replace(paths: ["signIn"], items: [:], isAnimated: true)
                }
                
//                IRACustomNavigationView(
//                    destination: IRASignInView(navigator: navigator),
//                    buttonText: "Get Started",
//                    action: {
//                        hasCompletedOnboarding = true
//                    }
//                )

            }
            .padding(.horizontal, 16)
        }
    }
}

//#Preview {
//    IRAOnboardingView()
//}
