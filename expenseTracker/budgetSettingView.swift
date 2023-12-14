
import SwiftUI

struct BudgetSettingView: View {
    @State private var selectedCategory: String?
    @State private var budgetAmount = ""
    @State private var selectedTimeFrame = "Weekly"

    // BudgetManager dependency
    @ObservedObject var budgetManager: BudgetManager

    var expenseCategories = ["Groceries", "Transportation", "Entertainment", "Housing", "Insurance", "Misc"]

    init(budgetManager: BudgetManager) {
        self.budgetManager = budgetManager
    }

    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)

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
                            .background(RoundedRectangle(cornerRadius: 50))
                            .foregroundColor(.green)
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
                        .background(Color.blue)
                        .cornerRadius(10)
                    }

                    Section(header: Text("Current Budgets").font(.title).foregroundColor(.black).bold()) {
                        List(budgetManager.budgets) { budget in
                            Text("\(budget.category): $\(budget.amount) \(budget.timeFrame)")
                        }
                        .listRowBackground(Color.green)
                    }
                }
                .background(
                    Image("dollarBill")
                        .resizable()
                        .scaledToFill()
                        .edgesIgnoringSafeArea(.all)
                )
                .foregroundColor(.white)
                .navigationBarTitle("Budget Setting")
                .accentColor(.green)
                .listStyle(GroupedListStyle())
            }
        }
    }
}

struct BudgetSettingView_Previews: PreviewProvider {
    static var previews: some View {
        BudgetSettingView(budgetManager: BudgetManager())
    }
}
