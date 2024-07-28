//
//  IRAHomeViewModel.swift
//  InstantRecipeApp
//
//  Created by Suraj Chand on 25/07/2024.
//

import Foundation
import Combine
import Appwrite
import JSONCodable

class IRAHomeViewModel: ObservableObject {
    private var client: Client
    private var databases: Databases
    
    @Published var recipeListState: APIState = .initial
    @Published var apiResponseValue: String = ""
    @Published var documentsList: [AppwriteModels.Document<[String: AnyCodable]>] = []
    
    init() {
        self.client = ClientManager.shared.client
        self.databases = Databases(self.client)
        callGetRecipes()
    }
    
    func callGetRecipes() {
        Task {
            await getRecipes()
        }
    }
    
    func getRecipes() async {
        DispatchQueue.main.async {
            self.recipeListState = .loading
        }
        do {
            let documentList = try await databases.listDocuments(
                databaseId: "666dd8f30018b4cd73b6",
                collectionId: "667efc49001de65d16ef",
                queries: []
            )
            DispatchQueue.main.async {
                self.documentsList = documentList.documents
                self.recipeListState = .success
            }
        } catch let error as AppwriteError {
            // Handle AppwriteException
            print("Appwrite exception: \(error)")
            DispatchQueue.main.async {
                self.recipeListState = .error
                self.apiResponseValue = error.description
            }
        } catch {
            // Handle other generic exceptions
            print("Generic exception: \(error)")
            DispatchQueue.main.async {
                self.recipeListState = .error
                self.apiResponseValue = error.localizedDescription
            }
        }
    }
}
