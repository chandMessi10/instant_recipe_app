//
//  IRACookingDurationView.swift
//  InstantRecipeApp
//
//  Created by Suraj Chand on 26/07/2024.
//

import SwiftUI

struct IRACookingDurationView: View {
    @Binding var sliderValue: Float
    @State private var timerIntervalValue: TimeInterval = 60
    @State private var colorValue: UIColor = UIColor(hex: "#1FCC79")
    @State private var diameterValue: CGFloat = 30

    var body: some View {
        VStack {
            HStack {
                Text("Cooking Duration")
                    .font(.system(size: 17))
                    .fontWeight(.bold)
                    .foregroundColor(Color(UIColor(hex: "#3E5481")))
                Text("(in minutes)")
                    .font(.system(size: 17))
                    .fontWeight(.medium)
                    .foregroundColor(Color(UIColor(hex: "#9FA5C0")))
                Spacer()
            }
            .padding(.bottom, 16)
            
            HStack {
                Text("<10")
                    .font(.system(size: 15))
                    .fontWeight(.bold)
                    .foregroundColor(Color(UIColor(hex: "#1FCC79")))
                Spacer()
                Text("30")
                    .font(.system(size: 15))
                    .fontWeight(.bold)
                    .foregroundColor(Color(UIColor(hex: (sliderValue == 30 || sliderValue >= 30) ? "#1FCC79" : "#9FA5C0")))
                Spacer()
                Text(">60")
                    .font(.system(size: 15))
                    .fontWeight(.bold)
                    .foregroundColor(Color(UIColor(hex: sliderValue >= 60 ? "#1FCC79" : "#9FA5C0")))
            }
            .padding(.bottom, 16)
            
            IRASwiftUISliderView(
                value: $sliderValue,
                maxValue: $timerIntervalValue,
                tintColor: $colorValue,
                thumbDiameter: $diameterValue
            )
            .padding(.bottom, 24)
        }
    }
}
