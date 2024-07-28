//
//  IRACurrentTimeUtil.swift
//  InstantRecipeApp
//
//  Created by Suraj Chand on 26/07/2024.
//

import Foundation

func getCurrentTime() -> String {
    let currentDate = Date()
    let formatter = DateFormatter()
    formatter.timeStyle = .medium
    formatter.dateStyle = .none
    return formatter.string(from: currentDate)
}
