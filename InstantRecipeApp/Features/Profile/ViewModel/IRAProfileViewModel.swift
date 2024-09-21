//
//  IRAProfileViewModel.swift
//  InstantRecipeApp
//
//  Created by Suraj Chand on 25/07/2024.
//

import Foundation
import Appwrite
import JSONCodable

class IRAProfileViewModel: ObservableObject {
    private var client: Client
    private var account: Account
    private var databases: Databases
    
    @Published var profileState: APIState = .initial
    @Published var apiResponseValue: String = ""
    @Published var apiToastType: ToastType = ToastType.idle
    @Published var userDetail: IRAProfileDetailModel? = nil
    
    @Published var recipeListState: APIState = .initial
    @Published var recipeListApiResponseValue: String = ""
    @Published var documentsList: [AppwriteModels.Document<[String: AnyCodable]>] = []
    
    static let userDetailShared = IRAProfileViewModel()
    
    init() {
        self.client = ClientManager.shared.client
        self.account = Account(self.client)
        self.databases = Databases(self.client)
        fetchData()
    }
    
    func fetchData() {
        Task {
            await getUserProfile()
        }
    }
    
    func getUserProfile() async {
        DispatchQueue.main.async {
            self.profileState = .loading
        }
        do {
            let user = try await account.get()
            DispatchQueue.main.async {
                self.userDetail = IRAProfileDetailModel(
                    id: user.id,
                    name:  user.name,
                    emailAddress:  user.email,
                    emailAddressVerified: user.emailVerification,
                    registrationDateTime: user.registration
                )
                self.profileState = .success
                Task {
                    await self.getRecipes(chefId: user.id)
                }
            }
        } catch let error as AppwriteError {
            // Handle AppwriteException
            print("Appwrite exception: \(error)")
            DispatchQueue.main.async {
                self.profileState = .error
                self.apiResponseValue = error.description
            }
        } catch {
            // Handle other generic exceptions
            print("Generic exception: \(error)")
            DispatchQueue.main.async {
                self.profileState = .error
                self.apiResponseValue = error.localizedDescription
            }
        }
    }
    
    func getRecipes(chefId: String) async {
        DispatchQueue.main.async {
            self.recipeListState = .loading
        }
        do {
            let documentList = try await databases.listDocuments(
                databaseId: "666dd8f30018b4cd73b6",
                collectionId: "667efc49001de65d16ef",
                queries: [
                    Query.equal("chefId", value: chefId)
                ]
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
                self.recipeListApiResponseValue = error.description
            }
        } catch {
            // Handle other generic exceptions
            print("Generic exception: \(error)")
            DispatchQueue.main.async {
                self.recipeListState = .error
                self.recipeListApiResponseValue = error.localizedDescription
            }
        }
    }
}
