//
//  IRASearchView.swift
//  InstantRecipeApp
//
//  Created by Suraj Chand on 27/02/2024.
//

import SwiftUI
import LinkNavigator

struct IRASearchView: View {
    let navigator: LinkNavigatorType
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
        VStack {
            HStack {
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
                
                Spacer()
                
                Button(action: {
                    isShowingFilterSheet.toggle()
                }) {
                    Image("Filter")
                }
                .sheet(isPresented: $isShowingFilterSheet) {
                    sheetView()
                        .presentationDetents([.medium])
                }
                .padding(.horizontal, 4)
            }
            .padding(10)
            Rectangle()
                .frame(height: 8)
                .foregroundColor(Color(UIColor(hex: "#F4F5F7")))
            Spacer()
        }
        .navigationBarItems(
            trailing:  Button(action: {
                navigator.back(isAnimated: true)
            }) {
                Image(systemName: "xmark")
                    .imageScale(.large)
                    .foregroundColor(Color.gray)
            }
        )
    }
    
    // Define a custom view method
    func sheetView() -> some View {
        return NavigationStack {
            VStack {
                Text("Add a Filter")
                    .font(.system(size: 17))
                    .foregroundColor(Color(UIColor(hex: "#3E5481")))
                    .fontWeight(.bold)
                    .padding(.bottom, 16)
                
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
                
                IRACookingDurationView(sliderValue: $sliderValue)
                
                HStack {
                    IRACustomButton(
                        buttonText: "Cancel",
                        action: {
                            isShowingFilterSheet.toggle()
                        },
                        isSecondaryButton: true
                    )
                    IRACustomButton(
                        buttonText: "Done",
                        action: {
                            print("filtering recipes time :: \(extractIntValue(from: $sliderValue))")
//                            isShowingFilterSheet.toggle()
                        }
                    )
                }.padding(.bottom, 0)
            }
            .padding(.horizontal, 16)
        }
    }
}

//#Preview {
//    IRASearchView()
//}
