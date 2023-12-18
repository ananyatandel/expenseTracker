//
//  Budget.swift
//  expenseTracker

import Foundation

struct Budget: Identifiable, Codable {
    var id = UUID()
    let category: String
    var amount: Double
    var timeFrame: TimeFrame
}

enum TimeFrame: String, Codable, CaseIterable {
    case weekly = "Weekly"
    case monthly = "Monthly"
}

class BudgetManager: ObservableObject {
    @Published var budgets: [Budget] = []

    init() {
        loadBudgets()
    }

    func setBudget(_ newBudget: Budget) {
        if let index = budgets.firstIndex(where: { $0.category == newBudget.category }) {
            budgets[index] = newBudget
        } else {
            budgets.append(newBudget)
        }
        saveBudgets()
    }

    func deleteBudget(at offsets: IndexSet) {
        budgets.remove(atOffsets: offsets)
        saveBudgets()
    }

    private func saveBudgets() {
        if let encoded = try? JSONEncoder().encode(budgets) {
            UserDefaults.standard.set(encoded, forKey: "budgets")
        }
    }

    private func loadBudgets() {
        if let savedBudgets = UserDefaults.standard.object(forKey: "budgets") as? Data {
            if let decodedBudgets = try? JSONDecoder().decode([Budget].self, from: savedBudgets) {
                budgets = decodedBudgets
            }
        }
    }
}
