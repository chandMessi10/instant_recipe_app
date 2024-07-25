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
    
    init(navigator: LinkNavigatorType) {
        self._viewModel = StateObject(wrappedValue: IRAAddEditRecipeViewModel())
        self.navigator = navigator
    }
    
    var body: some View {
        VStack(alignment: .leading,spacing: 16) {
            ZStack {
                if let image = image {
                    Rectangle()
                        .strokeBorder(style: StrokeStyle(lineWidth: 2, dash: [8]))
                        .frame(height: 200)
                        .foregroundColor(Color(UIColor(hex: "#D0DBEA")))
                        .cornerRadius(12)
                    Image(uiImage: image)
                        .resizable()
                        .frame(maxWidth: .infinity, maxHeight: 200)
                        .cornerRadius(12)
                } else {
                    Rectangle()
                        .strokeBorder(style: StrokeStyle(lineWidth: 2, dash: [8]))
                        .frame(height: 200)
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
                        
//                        Text("(upto 2 MB)")
//                            .font(.system(size: 12))
//                            .fontWeight(.medium)
//                            .foregroundColor(Color(UIColor(hex: "#9FA5C0")))
                    }
                }
            }
            
            HStack {
                Spacer()
                Button("Select Photo") {
                    showingImagePicker = true
                }
                .padding()
                .sheet(isPresented: $showingImagePicker) {
                    IRAPhotoPickerView(image: $image, imagePath: $imagePath)
                }
                Spacer()
            }
            
            Text("\(String(describing: imagePath))")
//            Text("Food Name")
                .font(.system(size: 17))
                .fontWeight(.semibold)
                .foregroundColor(Color(UIColor(hex: "#3E5481")))
                .padding(.bottom, 12)
            
            IRACustomButton(
                buttonText: "Upload",
                action: {
                    if let imagePath = imagePath {
                        await viewModel.uploadImage(val: imagePath)
                    } else {
                        print("Image not selected")
                    }
                },
                isLoading: viewModel.recipeAddState == .loading
            )
        }
        .padding()
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
        .onDisappear {
            if let imagePath = imagePath {
                deleteTemporaryImage(at: imagePath)
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
