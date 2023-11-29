//
//  categorizationView.swift
//  expenseTracker
//
//  Created by Ananya Tandel on 10/30/23.
//

// testing commit 

import SwiftUI

struct Category: Identifiable {
    let id = UUID()
    let name: String
}

struct CategorizationView: View {
    @ObservedObject var budgetManager: BudgetManager

    init(budgetManager: BudgetManager) {
        self.budgetManager = budgetManager
    }

    @State private var categories: [Category] = []
    @State private var categoryName: String = ""
    @State private var selectedCategory: String?

    var allCategories: [String] {
        return categories.map { $0.name } + budgetManager.budgets.map { $0.category }
    }

    var isCategoryNameValid: Bool {
        return !categoryName.trimmingCharacters(in: .whitespaces).isEmpty
    }

    var body: some View {
        VStack {
            Text("Manage Categories")
                .font(.largeTitle)
                .foregroundColor(.purple)
                .padding()

            TextField("Enter Custom Category", text: $categoryName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .foregroundColor(.black)

            Button("Add Category") {
                guard isCategoryNameValid else {
                    // Handle invalid input
                    return
                }

                let newCategory = Category(name: categoryName)
                categories.append(newCategory)
                categoryName = ""
            }
            .foregroundColor(.white)
            .padding()
            .background(isCategoryNameValid ? Color.green : Color.gray)
            .cornerRadius(8.0)
            .padding()

            List {
                ForEach(categories) { category in
                    Text(category.name)
                        .font(.headline)
                        .foregroundColor(.blue)
                }
            }
            .listStyle(PlainListStyle())
        }
        .background(Color.gray.opacity(0.1))
        .cornerRadius(15)
        .padding()
        .navigationTitle("Categories")
    }
}

struct CategorizationView_Previews: PreviewProvider {
    static var previews: some View {
        CategorizationView(budgetManager: BudgetManager())
    }
}

