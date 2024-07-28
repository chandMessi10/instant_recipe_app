//
//  IRARecipeDetailModel.swift
//  InstantRecipeApp
//
//  Created by Suraj Chand on 26/07/2024.
//

import Foundation

struct IRARecipeDetailModel: Decodable {
    let recipeName: String
    let recipeImageId: String
    let recipeCookingTime: Int
    let recipeDescription: String
    let chefName: String
    let recipeCategory: String
    let chefId: String

    func toDictionary() -> [String: Any] {
        return [
            "recipeName": recipeName,
            "recipeImageId": recipeImageId,
            "recipeCookingTime": recipeCookingTime,
            "recipeDescription": recipeDescription,
            "chefName": chefName,
            "recipeCategory": recipeCategory,
            "chefId": chefId
        ]
    }
}

enum RecipeCategory: String, Decodable {
    case food = "Food"
    case drink = "Drink"
}
