//
//  IRASearchView.swift
//  InstantRecipeApp
//
//  Created by Suraj Chand on 27/02/2024.
//

import SwiftUI

struct IRASearchView: View {
    @State private var searchText = ""
    @Environment(\.presentationMode) var presentationMode
    @State private var isShowingFilterSheet = false
    @State private var isEditing = false
    
    /// for category
    @State private var selectedOptions: Set<String> = ["All"]
    let options = ["All", "Food", "Drink"]
    
    /// for slider
    @State private var sliderValue: Float = 30
    @State private var timerIntervalValue: TimeInterval = 60
    @State private var colorValue: UIColor = UIColor(hex: "#1FCC79")
    @State private var diameterValue: CGFloat = 30
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    HStack {
                        IRABackButtonView()
                        
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(Color(UIColor(hex: "#2E3E5C")))
                            
                            TextField("Search", text: $searchText)
                                .foregroundColor(Color(UIColor(hex: "#3E5481")))
                                .font(.system(size: 15))
                                .fontWeight(.medium)
                                .padding(.trailing, 0)
                                .textInputAutocapitalization(TextInputAutocapitalization.never)
                            if !searchText.isEmpty {
                                Button(action: {
                                    searchText = ""
                                }) {
                                    Image(systemName: "xmark.circle.fill")
                                        .foregroundColor(Color(UIColor(hex: "#2E3E5C")))
                                }
                            }
                            
                        }
                        .padding(16)
                        .background(Color(UIColor(hex: "#F4F5F7")).clipShape(RoundedRectangle(cornerRadius:32)))
                        .padding(.horizontal, 8)
                        
                        Button(action: {
                            isShowingFilterSheet.toggle()
                        }) {
                            Image("Filter")
                        }
                        .sheet(isPresented: $isShowingFilterSheet) {
                            sheetView()
                                .presentationDetents([.medium, .large])
                        }
                    }
                    .padding()
                    Rectangle()
                        .frame(height: 8)
                        .foregroundColor(Color(UIColor(hex: "#F4F5F7")))
                    Spacer()
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
    
    // Define a custom view method
    func sheetView() -> some View {
        return NavigationStack {
            VStack {
                Text("Add a Filter")
                    .font(.system(size: 17))
                    .foregroundColor(Color(UIColor(hex: "#3E5481")))
                    .fontWeight(.bold)
                    .padding(.bottom, 32)
                
                // Category Chips Option
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
                                    // Toggle the selected state of the option
                                    if selectedOptions.contains(option) {
                                        selectedOptions.remove(option)
                                    } else {
                                        selectedOptions.insert(option)
                                    }
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
                .padding(.bottom, 16)
                
                
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
                        .foregroundColor(Color(UIColor(hex: ($sliderValue.wrappedValue == 30 || $sliderValue.wrappedValue >= 30) ?  "#1FCC79" : "#9FA5C0")))
                    Spacer()
                    Text(">60")
                        .font(.system(size: 15))
                        .fontWeight(.bold)
                        .foregroundColor(Color(UIColor(hex: $sliderValue.wrappedValue >= 60 ?  "#1FCC79" : "#9FA5C0")))
                }.padding(.bottom, 16)
                
                SwiftUISlider(
                    value: $sliderValue,
                    maxValue: $timerIntervalValue,
                    tintColor: $colorValue,
                    thumbDiameter: $diameterValue
                )
                .padding(.bottom, 24)
                
                HStack {
                    IRACustomButton(
                        buttonText: "Cancel",
                        action: {
    //                        presentationMode.wrappedValue.dismiss()
                            isShowingFilterSheet.toggle()
                        },
                        isSecondaryButton: true
                    )
                    IRACustomButton(
                        buttonText: "Done",
                        action: {
                            print("filtering recipes")
                            isShowingFilterSheet.toggle()
                        }
                    )
                }
            }.padding(.horizontal, 16)
        }
        .interactiveDismissDisabled()
    }
}

#Preview {
    IRASearchView()
}

/// Customizable UISlider Wrapper for SwiftUI
struct SwiftUISlider: UIViewRepresentable {
    
    /// UXSlider subclasses UISlider, touch
    class UXSlider: UISlider {
        
        // Function to be triggered by touchEvent
        var dragBegan: () -> Void = {}
        var dragMoved: () -> Void = {}
        var dragEnded: () -> Void = {}
        
        /// Initialize UXSlider by overriding existing UISlider initializer
        /// - Parameter frame: The frame rectangle for the slider view, measured in points.
        override init(frame: CGRect) {
            super.init(frame: frame)
            self.addTarget(self, action: #selector(onSliderValChanged(slider:event:)), for: .valueChanged)
        }
        
        /// UIEvent listener, listening on UISlider touchEvent
        @objc func onSliderValChanged(slider: UISlider, event: UIEvent) {
            if let touchEvent = event.allTouches?.first {
                switch touchEvent.phase {
                case .began:
                    dragBegan()
                case .moved:
                    dragMoved()
                case .ended:
                    dragEnded()
                default:
                    break
                }
            }
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
    
    final class Coordinator: NSObject {
        // The class property value is a binding: It’s a reference to the SwiftUISlider
        // value, which receives a reference to a @State variable value in ContentView.
        var value: Binding<Float>
        
        // Create the binding when you initialize the Coordinator
        init(value: Binding<Float>) {
            self.value = value
        }
        
        // Create a valueChanged(_:) action
        @objc func valueChanged(_ sender: UXSlider) {
            self.value.wrappedValue = sender.value
        }
    }
    
    @Binding var value: Float
    @Binding var maxValue: TimeInterval
    @Binding var tintColor: UIColor
    @Binding var thumbDiameter: CGFloat
    
    var dragBegan: () -> Void = {}
    var dragMoved: () -> Void = {}
    var dragEnded: () -> Void = {}
    
    func customizeSlider(_ slider: UXSlider) {
        slider.minimumTrackTintColor = tintColor.withAlphaComponent(0.6)
        slider.maximumTrackTintColor = tintColor.withAlphaComponent(0.15)
        slider.value = value
        //        slider.value = value.rounded(.toNearestOrEven)    // if stepped
        slider.maximumValue = Float(maxValue)
        
        // create slide thumb
        let thumbView = UIView()
        thumbView.backgroundColor = tintColor
        thumbView.layer.masksToBounds = false
        thumbView.frame = CGRect(x: 0, y: thumbDiameter / 2, width: thumbDiameter, height: thumbDiameter)
        thumbView.layer.cornerRadius = CGFloat(thumbDiameter / 2)
        
        // render thumbView as image, then set it as the thumb view image
        let imageRenderer = UIGraphicsImageRenderer(bounds: thumbView.bounds)
        let thumbImage = imageRenderer.image { rendererContext in
            thumbView.layer.render(in: rendererContext.cgContext)
        }
        slider.setThumbImage(thumbImage, for: .normal)
        
        // set drop shadow appearance
        slider.layer.shadowColor = UIColor.black.cgColor
        slider.layer.shadowOpacity = 0.2
        slider.layer.shadowOffset = CGSize(width: 0, height: 3)
        slider.layer.shadowRadius = 5
        
        // set slider’s events be continuous updated by value, triggers the
        // associated target’s action method repeatedly, as user moves thumb
        slider.isContinuous = true
    }
    
    func makeUIView(context: Context) -> UXSlider {
        
        let slider = UXSlider(frame: .zero)
        
        // set dragging event
        slider.dragBegan = dragBegan
        slider.dragMoved = dragMoved
        slider.dragEnded = dragEnded
        
        // apply slider customization
        customizeSlider(slider)
        
        slider.addTarget(
            context.coordinator,
            action: #selector(Coordinator.valueChanged(_:)),
            for: .valueChanged
        )
        
        return slider
    }
    
    func updateUIView(_ slider: UXSlider, context: Context) {
        // Coordinating data between UIView and SwiftUI view
        customizeSlider(slider)
        
        slider.addTarget(
            context.coordinator,
            action: #selector(Coordinator.valueChanged(_:)),
            for: .valueChanged
        )
    }
    
    func makeCoordinator() -> SwiftUISlider.Coordinator {
        Coordinator(value: $value)
    }
}


// TO USE IN SWIFTUI
//SwiftUISlider(
//    value: $value,
//    maxValue: $maxValue,
//    tintColor: $tintColor,
//    thumbDiameter: $thumbDiameter,
//    dragBegan: { print("dragBegan") },
//    dragMoved: { print("dragMoved") },
//    dragEnded: { print("dragEnded") }
//)
