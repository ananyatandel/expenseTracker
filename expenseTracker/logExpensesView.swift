//
//  logExpensesView.swift
//  expenseTracker
//
//  Created by Ananya Tandel on 10/26/23.
//

import Foundation

import SwiftUI

struct Expense: Identifiable {
    let id = UUID()
    let name: String
    let amount: String
    let date: Date
    let description: String
}

struct LogExpensesView: View {
    @State private var expenseName = ""
    @State private var expenseAmount = ""
    @State private var expenseDate = Date()
    @State private var expenseDescription = ""
    @State private var expenses: [Expense] = []
    //    @State private var selectedCategory: Category? // For picker selection
    //    @State private var customCategoryName: String = "" // For custom category creation

    @State private var expenseCategories = ["Groceries", "Transportation", "Entertainment", "Housing", "Insurance"]
    @State private var selectedCategory: String?
    @State private var customCategoryName = ""




    var body: some View {
//        ZStack {
//            // Background Image
//            Image("logExpensesBackground")
//                .resizable()
//                .scaledToFill()
//                .edgesIgnoringSafeArea(.all)
            Form {
                Section(header: Text("Log an Expense")) {
                    TextField("Expense Name", text: $expenseName)
                    TextField("Expense Amount ($)", text: $expenseAmount)
                        .keyboardType(.numberPad)
                    DatePicker("Expense Date", selection: $expenseDate)
                    TextField("Expense Description", text: $expenseDescription)
                    Picker("Select Category", selection: $selectedCategory) {
                        ForEach(expenseCategories, id: \.self) { category in
                            Text(category)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
//
//                    // If the user wants to create a custom category
//                    TextField("Custom Category", text: $customCategoryName)
                    Spacer()
                        .padding(.bottom, 0)
                    Button("Add Expense") {
                        _ = selectedCategory ?? customCategoryName

                        let newExpense = Expense(name: expenseName, amount: expenseAmount, date: expenseDate, description: expenseDescription)
                        expenses.append(newExpense)
                        // Clear the input fields
                        expenseName = ""
                        expenseAmount = ""
                        expenseDate = Date()
                        expenseDescription = ""
//                        selectedCatergory = nil
//                        customCategoryName = ""
                    }
                }

                Section(header: Text("Expense List")) {
                    List {
                        ForEach(expenses) { expense in
                            NavigationLink(destination: ExpenseDetailView(expense: expense)) {
                                Text(expense.name)
                            }
                        }
                    }
                }

            }
        }

    }


struct logExpensesView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}




//
//// logExpensesView.swift
//import SwiftUI
//
//struct Expense: Identifiable {
//    let id = UUID()
//    let name: String
//    let amount: String
//    let date: Date
//    let description: String
//}
//
//struct LogExpensesView: View {
//    @State private var expenseName = ""
//    @State private var expenseAmount = ""
//    @State private var expenseDate = Date()
//    @State private var expenseDescription = ""
//    @State private var expenses: [Expense] = []
//    @State private var expenseCategories = ["Groceries", "Transportation", "Entertainment", "Housing", "Insurance", "Misc"]
//    @State private var selectedCategory: String?
//    @State private var categories: [String] = []
//
//    var body: some View {
//        NavigationView {
//            Form {
//                Section(header: Text("Log an Expense")) {
//                    TextField("Expense Name", text: $expenseName)
//                    TextField("Expense Amount ($)", text: $expenseAmount)
//                        .keyboardType(.numberPad)
//                    DatePicker("Expense Date", selection: $expenseDate)
//                    TextField("Expense Description", text: $expenseDescription)
//                    Picker("Select Category", selection: $selectedCategory) {
//                        ForEach(categories, id: \.self) { category in
//                            Text(category)
//                        }
//                    }
//                    .pickerStyle(MenuPickerStyle())
//
//                    NavigationLink(destination: CategorizationView(budgetManager: BudgetManager(), selectedCategory: $selectedCategory, categories: $categories)) {
//                        Text("Manage Categories")
//                    }
//
//                    Button("Add Expense") {
//                        let newExpense = Expense(name: expenseName, amount: expenseAmount, date: expenseDate, description: expenseDescription)
//                        expenses.append(newExpense)
//                        expenseName = ""
//                        expenseAmount = ""
//                        expenseDate = Date()
//                        expenseDescription = ""
//                    }
//                }
//
//                Section(header: Text("Expense List")) {
//                    List {
//                        ForEach(expenses) { expense in
//                            NavigationLink(destination: ExpenseDetailView(expense: expense)) {
//                                Text(expense.name)
//                            }
//                        }
//                    }
//                }
//            }
//            .navigationBarTitle("Log Expenses")
//        }
//    }
//}
//
//struct logExpensesView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
//
