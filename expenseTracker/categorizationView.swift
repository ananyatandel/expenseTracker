//
//  categorizationView.swift
//  expenseTracker
//
//  Created by Ananya Tandel on 10/30/23.
//

import SwiftUI

struct Category: Identifiable {
    let id = UUID()
    let name: String
}

struct CategorizationView: View {
//    @State private var categories: [Category] = []
//    @State private var categoryName: String = ""
//    @State private var selectedCategory: String?
    @State var expenseCategories = ["Groceries", "Transportation", "Entertainment", "Housing", "Insurance"]

    @State private var categories: [Category] = []
       @State private var categoryName: String = ""
       @State private var selectedCategory: String?
       
       var allCategories: [String] {
           return categories.map { $0.name } + expenseCategories
       }

    var body: some View {
        VStack {
            Text("Manage Categories")
                .font(.title)
                .padding()

            TextField("Enter Custom Category", text: $categoryName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button("Add Category") {
                let newCategory = Category(name: categoryName)
                categories.append(newCategory)
                categoryName = ""
            }
            .foregroundColor(.pink)
            .padding()

            List {
                ForEach(categories) { category in
                    Text(category.name)
                }
            }
        }
        .navigationTitle("Categories")
    }
}
//
//struct CategorizationView: View {
//    @State private var categories: [String] = []
//    @State private var categoryName: String = ""
//    @State private var selectedCategory: String?
//
//    var body: some View {
//        VStack {
//            Text("Manage Categories")
//                .font(.title)
//                .padding()
//
//            TextField("Category Name", text: $categoryName)
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//                .padding()
//
//            Button("Add Category") {
//                categories.append(categoryName)
//                categoryName = ""
//            }
//            .foregroundColor(.blue)
//            .padding()
//
//            List {
//                ForEach(categories, id: \.self) { category in
//                    Text(category)
//                    ForEach(expenses.filter { $0.category == category }) { expense in
//                        NavigationLink(destination: ExpenseDetailView(expense: expense)) {
//                            Text(expense.name)
//                        }
//                    }
//                }
//            }
//        }
//        .navigationTitle("Categories")
//    }
//}


struct CategorizationView_Previews: PreviewProvider {
    static var previews: some View {
        CategorizationView()
    }
}

