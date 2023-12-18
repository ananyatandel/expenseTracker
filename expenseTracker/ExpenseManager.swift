//
//  ExpenseManager.swift
//  expenseTracker

import Foundation
// final commit message - ignore

class ExpenseManager: ObservableObject {
    @Published var expenses: [Expense] = []

    init() {
        loadExpenses()
    }

    func addExpense(_ expense: Expense) {
        expenses.append(expense)
        saveExpenses()
    }

    func deleteExpense(at offsets: IndexSet) {
        expenses.remove(atOffsets: offsets)
        saveExpenses()
    }

    private func saveExpenses() {
        if let encoded = try? JSONEncoder().encode(expenses) {
            UserDefaults.standard.set(encoded, forKey: "expenses")
        }
    }

    private func loadExpenses() {
        if let savedExpenses = UserDefaults.standard.object(forKey: "expenses") as? Data {
            if let decodedExpenses = try? JSONDecoder().decode([Expense].self, from: savedExpenses) {
                expenses = decodedExpenses
            }
        }
    }
}
