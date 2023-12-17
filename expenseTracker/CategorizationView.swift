//
//  CategorizationView.swift
//  concurrently working with LogExpensesView

import SwiftUI

struct Budget: Identifiable, Codable {
    var id = UUID()
    let category: String
    let amount: Double
    let timeFrame: String
}

struct Category: Identifiable {
    let id = UUID()
    let name: String
}

class BudgetManager: ObservableObject {
    @Published var budgets: [Budget] = []

    func setBudget(_ budget: Budget) {
        budgets.append(budget)
        saveBudgets()
    }

    private func saveBudgets() {
        let encoder = JSONEncoder()
        if let encodedData = try? encoder.encode(budgets) {
            UserDefaults.standard.set(encodedData, forKey: "budgets")
        }
    }

    private func loadBudgets() {
        if let savedData = UserDefaults.standard.data(forKey: "budgets"),
           let decodedBudgets = try? JSONDecoder().decode([Budget].self, from: savedData) {
            budgets = decodedBudgets
        }
    }

    init() {
        loadBudgets()
    }
}

struct CategorizationView: View {
    @ObservedObject var budgetManager: BudgetManager
    @EnvironmentObject var categoryManager: CategoryManager

    @State private var categoryName: String = ""

    var isCategoryNameValid: Bool {
        !categoryName.trimmingCharacters(in: .whitespaces).isEmpty
    }

    var body: some View {
        NavigationView {
            VStack {
                Image("logExpensesBackground")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                    .overlay(
                        VStack {
                            Text("Manage Categories")
                                .font(.largeTitle)
                                .foregroundColor(.black)
                                .padding()

                            TextField("Enter Custom Category", text: $categoryName)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding()
                                .foregroundColor(.black)

                            Button("Add Category") {
                                guard isCategoryNameValid else { return }
                                categoryManager.addCategory(categoryName)
                                categoryName = ""
                            }
                            .foregroundColor(.white)
                            .padding()
                            .background(isCategoryNameValid ? Color.green : Color.orange)
                            .cornerRadius(8.0)
                            .padding()

                            List(categoryManager.categories, id: \.self) { category in
                                Text(category)
                                    .font(.headline)
                                    .foregroundColor(.black)
                                    .padding()
                                    .listRowBackground(Color.white) // background of each row is white
                                
                                    .listRowInsets(EdgeInsets()) // remove default padding and separators
                            }
                            .listStyle(PlainListStyle()) // Removes extra padding and separators
                        }
                        .cornerRadius(15)
                        .padding()
                    )
            }
            .navigationBarHidden(true)
        }
    }
}


struct CategorizationView_Previews: PreviewProvider {
    static var previews: some View {
        CategorizationView(budgetManager: BudgetManager())
            .environmentObject(CategoryManager())
    }
}


