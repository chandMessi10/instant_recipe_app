//
//  IRARecipeDetailViewModel.swift
//  InstantRecipeApp
//
//  Created by Suraj Chand on 25/07/2024.
//

import Foundation
import Appwrite
import UIKit
import NIO

class IRARecipeDetailViewModel: ObservableObject {
    @Published var recipeImageState: APIState = .initial
    @Published var apiResponseValue: String = ""
    @Published var image: UIImage?
    
    private var client: Client
    private var storage: Storage
    
    init() {
        self.client = ClientManager.shared.client
        self.storage = Storage(self.client)
    }
    
    func fetchImagePreview() {
        Task {
            await getImageView()
        }
    }
    
    // MARK -> Not in use right now
    func getImageView() async {
        Task {
            DispatchQueue.main.async {
                self.recipeImageState = .loading
            }
            do {
                let bytes = try await storage.getFileView(
                    bucketId: "6675b9630033239a91e6",
                    fileId: ""
                )
                DispatchQueue.main.async {
                    self.recipeImageState = .success
                    self.image = self.imageFromByteBuffer(bytes)
                }
            } catch let error as AppwriteError {
                // Handle AppwriteException
                print("Appwrite exception: \(error)")
                DispatchQueue.main.async {
                    self.recipeImageState = .error
                    self.apiResponseValue = error.description
                }
            } catch {
                // Handle other generic exceptions
                print("Generic exception: \(error)")
                DispatchQueue.main.async {
                    self.recipeImageState = .error
                    self.apiResponseValue = error.localizedDescription
                }
            }
        }
    }
    
    func imageFromByteBuffer(_ buffer: ByteBuffer) -> UIImage? {
        var mutableBuffer = buffer
        if let data = mutableBuffer.readData(length: mutableBuffer.readableBytes) {
            return UIImage(data: data)
        }
        return nil
    }
}
