//
//  IRAAddEditRecipeViewModel.swift
//  InstantRecipeApp
//
//  Created by Suraj Chand on 25/07/2024.
//

import Foundation
import Appwrite

class IRAAddEditRecipeViewModel: ObservableObject {
    @Published var foodName: String = ""
    @Published var foodNameError: String = ""
    
    @Published var recipeAddState: APIState = .initial
    @Published var apiResponseValue: String = ""
    @Published var apiToastType: ToastType = ToastType.idle
    
    private var client: Client
    private var storage: Storage
    
    init() {
        self.client = ClientManager.shared.client
        self.storage = Storage(self.client)
    }
    
    func uploadImage(val filePath : String) async {
        DispatchQueue.main.async {
            self.recipeAddState = .loading
        }
        do {
            _ = try await storage.createFile(
                bucketId: "6675b9630033239a91e6",
                fileId: ID.unique(),
                file: InputFile.fromPath(filePath)
            )
            DispatchQueue.main.async {
                self.recipeAddState = .success
                self.apiToastType = ToastType.success
            }
        } catch let error as AppwriteError {
            // Handle AppwriteException
            print("Appwrite exception: \(error)")
            DispatchQueue.main.async {
                self.recipeAddState = .error
                self.apiResponseValue = error.description
                self.apiToastType = ToastType.error
            }
        } catch {
            // Handle other generic exceptions
            print("Generic exception: \(error)")
            DispatchQueue.main.async {
                self.recipeAddState = .error
                self.apiResponseValue = error.localizedDescription
                self.apiToastType = ToastType.error
            }
        }
    }
}
