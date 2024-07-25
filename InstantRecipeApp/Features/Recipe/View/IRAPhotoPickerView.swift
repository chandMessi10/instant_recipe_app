//
//  IRAPhotoPickerView.swift
//  InstantRecipeApp
//
//  Created by Suraj Chand on 25/07/2024.
//

import SwiftUI
import PhotosUI

struct IRAPhotoPickerView: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    @Binding var imagePath: String?
    @Environment(\.presentationMode) var presentationMode
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        configuration.selectionLimit = 1
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        var parent: IRAPhotoPickerView
        
        init(_ parent: IRAPhotoPickerView) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true, completion: nil)
            
            guard let provider = results.first?.itemProvider else { return }
            
            if provider.canLoadObject(ofClass: UIImage.self) {
                provider.loadObject(ofClass: UIImage.self) { [self] (image, error) in
                    if let image = image as? UIImage {
                        DispatchQueue.main.async {
                            if let compressedData = self.compressImage(image, to: 4) {
                                let dateFormatter = DateFormatter()
                                dateFormatter.dateFormat = "yyyyMMdd_HHmmss"
                                let dateString = dateFormatter.string(from: Date())
                                if let tempImagePath = self.saveToTemporaryDirectory(data: compressedData, fileName: "recipe_image_\(dateString).jpg") {
                                    self.parent.image = image
                                    self.parent.imagePath = tempImagePath
                                } else {
                                    self.parent.showAlert(message: "Failed to save compressed image.")
                                }
                            } else {
                                self.parent.showAlert(message: "Image exceeds the maximum size of 4MB.")
                            }
                        }
                    } else {
                        parent.showAlert(message: "Failed to load image.")
                    }
                }
            } else {
                parent.showAlert(message: "Selected item is not an image.")
            }
        }
        
        private func compressImage(_ image: UIImage, to maxSizeInMB: Int) -> Data? {
            let maxSizeInBytes = maxSizeInMB * 1024 * 1024
            var compression: CGFloat = 1.0
            var compressedData: Data?
            
            repeat {
                if let data = image.jpegData(compressionQuality: compression) {
                    compressedData = data
                    if data.count < maxSizeInBytes {
                        break
                    } else {
                        compression -= 0.1
                    }
                }
            } while compression > 0.0
            
            return compressedData
        }
        
        private func saveToTemporaryDirectory(data: Data, fileName: String) -> String? {
            let temporaryDirectoryURL = FileManager.default.temporaryDirectory
            let fileURL = temporaryDirectoryURL.appendingPathComponent(fileName)
            do {
                try data.write(to: fileURL)
                return fileURL.path
            } catch {
                print("Error saving file to temporary directory: \(error)")
                return nil
            }
        }
    }
    
    func showAlert(message: String) {
        self.alertMessage = message
        self.showAlert = true
    }
}


