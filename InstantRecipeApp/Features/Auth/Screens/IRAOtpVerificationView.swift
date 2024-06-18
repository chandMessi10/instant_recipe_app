//
//  IRAOtpVerificationView.swift
//  InstantRecipeApp
//
//  Created by Suraj Chand on 23/02/2024.
//

import SwiftUI
import OTPView

struct IRAOtpVerificationView: View {
    @StateObject var iraOTPViewModel: IRAOTPViewModel
    
    init() {
        self._iraOTPViewModel = StateObject(wrappedValue: IRAOTPViewModel())
    }
    
    var body: some View {
//        NavigationView {
            VStack {
                IRACustomHeaderView(
                    headerTitle: "Check your email",
                    headerSubTitle: "We have sent the code to your email"
                )
                
                OtpView(
                    activeIndicatorColor: Color(UIColor(hex: "#1FCC79")),
                    inactiveIndicatorColor: Color(UIColor(hex: "#D0DBEA")),
                    length: 4,
                    doSomething: { value in
                        // Do something with the value input
                    }
                )
                .padding(.bottom, 48)
                .onAppear {
                    iraOTPViewModel.startTimer()
                }
                
                HStack {
                    Text("code expires in:")
                        .font(.system(size: 15))
                        .foregroundColor(Color(UIColor(hex: "#2E3E5C")))
                        .fontWeight(.medium)
                    Text(iraOTPViewModel.timeStr)
                        .font(.system(size: 15))
                        .foregroundColor(Color(UIColor(hex: "#FF6464")))
                        .fontWeight(.medium)
                        .onReceive(iraOTPViewModel.timer) { _ in
                            iraOTPViewModel.countDownString()
                        }
                }.padding(.bottom, 24)
                
                IRACustomButton(
                    buttonText: "Verify",
                    action: {
                        
                    },
                    isButtonDisabled: false
                )
                .padding(.bottom, 16)
                
                IRACustomButton(
                    buttonText: "Send again",
                    action: {
                        iraOTPViewModel.startTimer()
                    },
                    isButtonDisabled: !iraOTPViewModel.timerExpired,
                    hasBorder: true
                )
                Spacer()
            }
            .padding()
//            .navigationBarItems(leading: IRABackButtonView())
//        }
//        .navigationBarBackButtonHidden()
    }
}

#Preview {
    IRAOtpVerificationView()
}
