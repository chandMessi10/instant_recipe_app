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
    @Published var foodDescription: String = ""
    @Published var foodDescriptionError: String = ""
    
    @Published var recipeImageUploadState: APIState = .initial
    @Published var recipeUploadState: APIState = .initial
    @Published var apiResponseValue: String = ""
    @Published var apiToastType: ToastType = ToastType.idle
    
    @Published var userDetailData = IRAProfileViewModel.userDetailShared
    
    private var client: Client
    private var storage: Storage
    private var databases: Databases
    
    init() {
        self.client = ClientManager.shared.client
        self.storage = Storage(self.client)
        self.databases = Databases(self.client)
    }
    
    func validateFoodName() {
        if foodName.isEmpty {
            foodNameError = "Please enter food name"
        } else {
            foodNameError = ""
        }
    }
    
    func validateFoodDescription() {
        if foodDescription.isEmpty {
            foodDescriptionError = "*Required"
        } else {
            foodDescriptionError = ""
        }
    }
    
    func uploadImage(
        val filePath : String,
        val category : String,
        val time : Int
    ) async {
        DispatchQueue.main.async {
            self.recipeImageUploadState = .loading
        }
        do {
            let file = try await storage.createFile(
                bucketId: "6675b9630033239a91e6",
                fileId: ID.unique(),
                file: InputFile.fromPath(filePath)
            )
            DispatchQueue.main.async {
                Task {
                    await self.uploadRecipe(
                        val: IRARecipeDetailModel(
                            recipeName: self.foodName,
                            recipeImageId: file.id,
                            recipeCookingTime: time,
                            recipeDescription: self.foodDescription,
                            chefName: self.userDetailData.userDetail?.name ?? "N/A",
                            recipeCategory: category,
                            chefId: self.userDetailData.userDetail?.id ?? "N/A"
                        )
                    )
                }
                self.recipeImageUploadState = .success
                self.apiToastType = ToastType.success
            }
        } catch let error as AppwriteError {
            // Handle AppwriteException
            print("Appwrite exception: \(error)")
            DispatchQueue.main.async {
                self.recipeImageUploadState = .error
                self.apiResponseValue = error.description
                self.apiToastType = ToastType.error
            }
        } catch {
            // Handle other generic exceptions
            print("Generic exception: \(error)")
            DispatchQueue.main.async {
                self.recipeImageUploadState = .error
                self.apiResponseValue = error.localizedDescription
                self.apiToastType = ToastType.error
            }
        }
    }
    
    func uploadRecipe(val recipeDetail: IRARecipeDetailModel) async {
        DispatchQueue.main.async {
            self.recipeUploadState = .loading
        }
        do {
            let _ = try await databases.createDocument(
                databaseId: "666dd8f30018b4cd73b6",
                collectionId: "667efc49001de65d16ef",
                documentId: ID.unique(),
                data: recipeDetail.toDictionary()
            )
            DispatchQueue.main.async {
                self.recipeUploadState = .success
                self.apiToastType = ToastType.success
            }
        } catch let error as AppwriteError {
            // Handle AppwriteException
            print("Appwrite exception: \(error)")
            DispatchQueue.main.async {
                self.recipeUploadState = .error
                self.apiResponseValue = error.description
                self.apiToastType = ToastType.error
            }
        } catch {
            // Handle other generic exceptions
            print("Generic exception: \(error)")
            DispatchQueue.main.async {
                self.recipeUploadState = .error
                self.apiResponseValue = error.localizedDescription
                self.apiToastType = ToastType.error
            }
        }
    }
}
