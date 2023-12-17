//
//  CategoryManager.swift
//  expenseTracker


import Foundation
import SwiftUI

class CategoryManager: ObservableObject {
    @Published var categories: [String] = ["Groceries", "Transportation", "Entertainment", "Housing", "Insurance", "Utilities", "Misc"]

    func addCategory(_ newCategory: String) {
        if !categories.contains(newCategory) {
            categories.append(newCategory)
        }
    }
}

