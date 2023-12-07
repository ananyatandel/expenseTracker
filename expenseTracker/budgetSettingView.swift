import SwiftUI

// Budget struct to represent the user's budget setting
struct Budget: Identifiable, Codable {
    var id = UUID()
    let category: String
    let amount: Double
    let timeFrame: String
}

// Manager class to handle budget-related operations
class BudgetManager: ObservableObject {
    @Published var budgets: [Budget] = []

    func setBudget(_ budget: Budget) {
        budgets.append(budget)
        let encoder = JSONEncoder()
        if let encodedData = try? encoder.encode(budgets) {
            UserDefaults.standard.set(encodedData, forKey: "budgets")
        }
    }
}

struct BudgetSettingView: View {
    @State private var selectedCategory: String?
    @State private var budgetAmount = ""
    @State private var selectedTimeFrame = "Weekly"

    // BudgetManager dependency
    @ObservedObject var budgetManager: BudgetManager

    var expenseCategories = ["Groceries", "Transportation", "Entertainment", "Housing", "Insurance"]

    init(budgetManager: BudgetManager) {
        self.budgetManager = budgetManager
    }

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Budget Details").font(.title).foregroundColor(.black).bold()) {
                    Picker("Select Category", selection: $selectedCategory) {
                        ForEach(expenseCategories, id: \.self) { category in
                            Text(category)
                                .font(.body)
                                .foregroundColor(.black)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .foregroundColor(.black)

                    TextField("Budget Amount ($)", text: $budgetAmount)
                        .keyboardType(.numberPad)
                        .foregroundColor(.blue)

                    VStack {
                        Text("Time Frame")
                            .font(.caption)
                            .foregroundColor(.black)

                        Picker("", selection: $selectedTimeFrame) {
                            Text("Weekly").tag("Weekly")
                            Text("Monthly").tag("Monthly")
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .background(RoundedRectangle(cornerRadius: 30).stroke(Color.gray, lineWidth: 2))
                        .foregroundColor(.blue)
                    }
                }

                Section {
                    Button("Set Budget") {
                        guard let selectedCategory = selectedCategory, !budgetAmount.isEmpty, let amount = Double(budgetAmount) else {
                            // Handle invalid input
                            return
                        }

                        let budget = Budget(category: selectedCategory, amount: amount, timeFrame: selectedTimeFrame)
                        budgetManager.setBudget(budget)
                    }
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.black)
                    .cornerRadius(10)
                }
            }
            .navigationTitle("Budget Setting")
            .accentColor(.pink)
            .listStyle(GroupedListStyle())
            .background(
                Image("budgetBackground")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            )
        }
        .background(Color.clear) // Set the background color of the outer NavigationView to clear
    }
}

struct BudgetSettingView_Previews: PreviewProvider {
    static var previews: some View {
        BudgetSettingView(budgetManager: BudgetManager())
    }
}



////
////  budgetSettingView.swift
////  expenseTracker
////
////  Created by Ananya Tandel on 11/7/23.
////
//
//
//import SwiftUI
//
//// Budget struct to represent the user's budget setting
//struct Budget: Identifiable, Codable {
//    var id = UUID()
//    let category: String
//    let amount: Double
//    let timeFrame: String
//}
//
//// Manager class to handle budget-related operations
//class BudgetManager: ObservableObject {
//    @Published var budgets: [Budget] = []
//
//    func setBudget(_ budget: Budget) {
//        budgets.append(budget)
//        let encoder = JSONEncoder()
//        if let encodedData = try? encoder.encode(budgets) {
//            UserDefaults.standard.set(encodedData, forKey: "budgets")
//        }
//    }
//}
//
//
//
//
//struct BudgetSettingView: View {
//    @State private var selectedCategory: String?
//    @State private var budgetAmount = ""
//    @State private var selectedTimeFrame = "Weekly"
//
//    // BudgetManager dependency
//    @ObservedObject var budgetManager: BudgetManager
//
//    var expenseCategories = ["Groceries", "Transportation", "Entertainment", "Housing", "Insurance"]
//
//    init(budgetManager: BudgetManager) {
//        self.budgetManager = budgetManager
//    }
//
//    var body: some View {
//        Form {
//            Section(header: Text("Budget Details").font(.title).foregroundColor(.black).bold()) {
//                Picker("Select Category", selection: $selectedCategory) {
//                    ForEach(expenseCategories, id: \.self) { category in
//                        Text(category)
//                            .font(.body)
//                            .foregroundColor(.black)
//                    }
//                }
//                .pickerStyle(MenuPickerStyle())
//                .foregroundColor(.black)
//
//                TextField("Budget Amount ($)", text: $budgetAmount)
//                    .keyboardType(.numberPad)
//                    .foregroundColor(.blue)
//
//                VStack {
//                    Text("Time Frame")
//                        .font(.caption)
//                        .foregroundColor(.black)
//
//                    Picker("", selection: $selectedTimeFrame) {
//                        Text("Weekly").tag("Weekly")
//                        Text("Monthly").tag("Monthly")
//                    }
//                    .pickerStyle(SegmentedPickerStyle())
//                    .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 2))
//                    .foregroundColor(.blue)
//                }
//            }
//
//            Section {
//                Button("Set Budget") {
//                    guard let selectedCategory = selectedCategory, !budgetAmount.isEmpty, let amount = Double(budgetAmount) else {
//                        // Handle invalid input
//                        return
//                    }
//
//                    let budget = Budget(category: selectedCategory, amount: amount, timeFrame: selectedTimeFrame)
//                    budgetManager.setBudget(budget)
//                }
//                .foregroundColor(.white)
//                .padding()
//                .frame(maxWidth: .infinity)
//                .background(Color.black)
//                .cornerRadius(10)
//            }
//        }
//        .navigationTitle("Budget Setting")
//        .accentColor(.pink)
//        .listStyle(GroupedListStyle())
//        .background(Color(.systemGroupedBackground))
//    }
//}
//
//struct BudgetSettingView_Previews: PreviewProvider {
//    static var previews: some View {
//        BudgetSettingView(budgetManager: BudgetManager())
//    }
//}
//
//
//
