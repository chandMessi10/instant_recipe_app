//
//  IRAHelpers.swift
//  InstantRecipeApp
//
//  Created by Suraj Chand on 26/07/2024.
//

import SwiftUI

func extractIntValue(from binding: Binding<Float>) -> Int {
    return Int(binding.wrappedValue.rounded())
}

func extractDetail(from items: [String: Any?], key: String) -> String {
    if let value = items[key] as? String {
        return value
    }
    return "N/A" // Default value if the key does not exist or is nil
}

