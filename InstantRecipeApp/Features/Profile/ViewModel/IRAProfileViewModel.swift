//
//  IRAProfileViewModel.swift
//  InstantRecipeApp
//
//  Created by Suraj Chand on 25/07/2024.
//

import Foundation
import Appwrite

class IRAProfileViewModel: ObservableObject {
    private var client: Client
    private var account: Account
    
    @Published var profileState: APIState = .initial
    @Published var apiResponseValue: String = ""
    @Published var apiToastType: ToastType = ToastType.idle
    @Published var userDetail: IRAProfileDetailModel? = nil
    
    init() {
        self.client = ClientManager.shared.client
        self.account = Account(self.client)
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
                self.userDetail = IRAProfileDetailModel(id: user.id, name:  user.name, emailAddress:  user.email, emailAddressVerified: user.emailVerification, registrationDateTime: user.registration)
                self.profileState = .success
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
}
