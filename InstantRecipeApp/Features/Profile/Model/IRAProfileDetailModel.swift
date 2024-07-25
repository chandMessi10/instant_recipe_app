//
//  IRAProfileDetailModel.swift
//  InstantRecipeApp
//
//  Created by Suraj Chand on 25/07/2024.
//

import Foundation

struct IRAProfileDetailModel: Decodable {
    let id: String
    let name: String
    let emailAddress: String
    let emailAddressVerified: Bool
    let registrationDateTime: String
}
