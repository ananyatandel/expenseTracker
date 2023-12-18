//
//  CategoryManager.swift
//  expenseTracker

import Foundation

class CategoryManager: ObservableObject {
    @Published var categories: [String] {
        didSet {
            saveCategories()
        }
    }

    init() {
        if let savedCategories = UserDefaults.standard.object(forKey: "categories") as? [String] {
            categories = savedCategories
        } else {
            // Default categories if nothing saved in UserDefaults
            categories = ["Groceries", "Transportation", "Entertainment", "Housing", "Insurance", "Utilities", "Misc"]
        }
    }

    func addCategory(_ newCategory: String) {
        if !categories.contains(newCategory) {
            categories.append(newCategory)
        }
    }

    private func saveCategories() {
        UserDefaults.standard.set(categories, forKey: "categories")
    }
}

