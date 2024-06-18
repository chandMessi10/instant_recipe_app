//
//  AppWriteClientConfig.swift
//  InstantRecipeApp
//
//  Created by Suraj Chand on 16/06/2024.
//

import Foundation
import Appwrite

class ClientManager {
    static let shared = ClientManager()
    let client: Client

    private init() {
        self.client = Client()
            .setEndpoint("https://cloud.appwrite.io/v1")
            .setProject("666d6bec0028d0c01b84")
            .setSelfSigned(true)
    }
}
