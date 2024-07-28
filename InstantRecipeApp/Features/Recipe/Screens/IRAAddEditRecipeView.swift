//
//  IRAAddEditRecipeView.swift
//  InstantRecipeApp
//
//  Created by Suraj Chand on 05/03/2024.
//

import SwiftUI
import LinkNavigator

struct IRAAddEditRecipeView: View {
    let navigator: LinkNavigatorType
    @StateObject var viewModel: IRAAddEditRecipeViewModel
    @State private var isTapped = false
    @State private var image: UIImage?
    @State private var showingImagePicker = false
    @State private var imagePath: String?
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    // MARK
    @State private var sliderValue: Float = 30
    @State private var selectedOptions: Set<String> = []
    private let options = ["Food", "Drink"]
    private let isMultiSelection = false
    
    init(navigator: LinkNavigatorType) {
        self._viewModel = StateObject(wrappedValue: IRAAddEditRecipeViewModel())
        self.navigator = navigator
    }
    
    @FocusState private var focusedField: FocusElement?
    
    var body: some View {
        ScrollView {
            ZStack {
                VStack(alignment: .leading) {
                    ZStack {
                        if let image = image {
                            Rectangle()
                                .strokeBorder(style: StrokeStyle(lineWidth: 2, dash: [8]))
                                .frame(height: 300)
                                .foregroundColor(Color(UIColor(hex: "#D0DBEA")))
                                .cornerRadius(12)
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(maxWidth: .infinity, maxHeight: 300)
                                .cornerRadius(12)
                        } else {
                            Rectangle()
                                .strokeBorder(style: StrokeStyle(lineWidth: 2, dash: [8]))
                                .frame(height: 300)
                                .foregroundColor(Color(UIColor(hex: "#D0DBEA")))
                                .cornerRadius(12)
                            
                            VStack {
                                Image(systemName: "photo.badge.plus")
                                    .font(.title)
                                    .foregroundColor(Color(UIColor(hex: "#9FA5C0")))
                                    .padding(.bottom, 8)
                                
                                Text("Add Cover Photo")
                                    .font(.system(size: 15))
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color(UIColor(hex: "#3E5481")))
                                    .padding(.bottom, 8)
                                
                                Text("(upto 4 MB)")
                                    .font(.system(size: 12))
                                    .fontWeight(.medium)
                                    .foregroundColor(Color(UIColor(hex: "#9FA5C0")))
                            }
                        }
                    }
                    .padding(.vertical, 8)
                    
                    HStack {
                        Spacer()
                        Button(image != nil ? "Change Photo" : "Select Photo") {
                            showingImagePicker = true
                        }
                        .font(.caption)
                        .foregroundColor(Color.black)
                        .fontWeight(.semibold)
                        .sheet(isPresented: $showingImagePicker) {
                            IRAPhotoPickerView(image: $image, imagePath: $imagePath)
                        }
                        Spacer()
                    }.padding(.vertical, 8)
                    
                    IRACategorySelectionView(
                        selectedOptions: $selectedOptions,
                        options: options,
                        isMultiSelection: isMultiSelection
                    ).padding(.bottom, 8)
                    
                    Text("Food Name")
                        .font(.system(size: 17))
                        .fontWeight(.bold)
                        .foregroundColor(Color(UIColor(hex: "#3E5481")))
                    IRACustomTextFieldView(
                        prefixImage: "takeoutbag.and.cup.and.straw.fill",
                        textFieldLabel: "Enter food name",
                        isError: viewModel.foodNameError == "" ? false : true,
                        errorText: $viewModel.foodNameError,
                        fieldText: $viewModel.foodName,
                        submitLabel: .next,
                        onSubmit: {
                            focusedField = .foodDescription
                        },
                        keyboardType: .emailAddress
                    )
                    .padding(.bottom, 8)
                    .onChange(of: $viewModel.foodName.wrappedValue) { _, _ in
                        viewModel.validateFoodName()
                    }
                    .focused($focusedField, equals: .foodName)
                    
                    Text("Description")
                        .font(.system(size: 17))
                        .fontWeight(.bold)
                        .foregroundColor(Color(UIColor(hex: "#3E5481")))
                    
                    IRACustomTextEditorView(
                        textFieldLabel: "Enter description text",
                        isError: viewModel.foodDescriptionError == "" ? false : true,
                        errorText: $viewModel.foodDescriptionError,
                        fieldText: $viewModel.foodDescription
                    )
                    .padding(.bottom, 8)
                    .onChange(of: $viewModel.foodDescription.wrappedValue) { _, _ in
                        viewModel.validateFoodDescription()
                    }
                    .focused($focusedField, equals: .foodDescription)
                    
                    IRACookingDurationView(sliderValue: $sliderValue).padding(.bottom, 8)
                    
                    Spacer()
                    
                    IRACustomButton(
                        buttonText: "Upload",
                        action: {
                            print("category :: \(selectedOptions.first ?? "N/A")")
                            if selectedOptions.isEmpty {
                                showAlert = true
                                alertMessage = "Please choose one category"
                            } else
                            if imagePath == nil {
                                showAlert = true
                                alertMessage = "Please choose image"
                            } else if (viewModel.foodName != "" && viewModel.foodNameError == "") && (viewModel.foodDescription != "" && viewModel.foodDescriptionError == "") {
                                if let imagePath = imagePath {
                                    print("upload button clicked")
                                    await viewModel.uploadImage(
                                        val: imagePath,
                                        val: selectedOptions.first ?? "",
                                        val: extractIntValue(from: $sliderValue)
                                    )
                                } else {
                                    showAlert = true
                                    alertMessage = "Please choose image"
                                }
                            } else {
                                viewModel.validateFoodName()
                                viewModel.validateFoodDescription()
                            }
                        },
                        isLoading: viewModel.recipeImageUploadState == .loading || viewModel.recipeUploadState == .loading
                    )
                }
                .padding()
                .onDisappear {
                    if let imagePath = imagePath {
                        deleteTemporaryImage(at: imagePath)
                    }
                }
                
                if showAlert || viewModel.recipeUploadState == .error || viewModel.recipeImageUploadState == .error {
                    ToastView(message: (viewModel.recipeUploadState == .error || viewModel.recipeImageUploadState == .error) ? viewModel.apiResponseValue : alertMessage)
                        .zIndex(1)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                withAnimation {
                                    showAlert = false
                                    viewModel.recipeUploadState = .initial
                                    viewModel.recipeImageUploadState = .initial
                                }
                            }
                        }
                        .onTapGesture {
                            withAnimation {
                                showAlert = false
                                viewModel.recipeUploadState = .initial
                                viewModel.recipeImageUploadState = .initial
                            }
                        }
                }
            }
        }.onTapGesture {
            focusedField = Optional.none
        }.onChange(of: viewModel.recipeUploadState) { oldValue, newValue in
            if newValue == .success {
                navigator.fullSheet(
                    paths: ["recipeUploadSuccess"],
                    items: [:],
                    isAnimated: true,
                    prefersLargeTitles: false
                )
            }
        }
    }
    
    private func deleteTemporaryImage(at path: String) {
        let fileManager = FileManager.default
        do {
            try fileManager.removeItem(atPath: path)
            print("Temporary image deleted")
        } catch {
            print("Error deleting temporary image: \(error)")
        }
    }
}

//#Preview {
//    IRAAddEditRecipeView()
//}
