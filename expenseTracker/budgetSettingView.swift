import SwiftUI

struct BudgetSettingView: View {
    @EnvironmentObject var categoryManager: CategoryManager
    @ObservedObject var budgetManager: BudgetManager

    @State private var selectedCategory: String = ""
    @State private var budgetAmount: String = ""
    @State private var selectedTimeFrame: TimeFrame = .weekly

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Create Budget")) {
                    Picker("Select Category", selection: $selectedCategory) {
                        ForEach(categoryManager.categories, id: \.self) { category in
                            Text(category).tag(category)
                        }
                    }

                    TextField("Budget Amount", text: $budgetAmount)
                        .keyboardType(.decimalPad)

                    Picker("Time Frame", selection: $selectedTimeFrame) {
                        ForEach(TimeFrame.allCases, id: \.self) { timeFrame in
                            Text(timeFrame.rawValue).tag(timeFrame)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())

                    Button("Set Budget") {
                        setBudget()
                    }
                }

                Section(header: Text("Current Budgets")) {
                    List {
                        ForEach(budgetManager.budgets) { budget in
                            VStack(alignment: .leading) {
                                Text(budget.category)
                                    .font(.headline)
                                Text("Amount: \(budget.amount, specifier: "%.2f")")
                                Text("Time Frame: \(budget.timeFrame.rawValue)")
                            }
                        }
                        .onDelete(perform: deleteBudget)
                    }
                }
            }
            .navigationBarTitle("Budget Settings", displayMode: .inline)
            .background(
                            Image("quizBackground") // Replace with your actual background image name
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .edgesIgnoringSafeArea(.all)
                        )
        }
    }

    private func setBudget() {
        if let amount = Double(budgetAmount), !selectedCategory.isEmpty {
            let newBudget = Budget(category: selectedCategory, amount: amount, timeFrame: selectedTimeFrame)
            budgetManager.setBudget(newBudget)
            resetFields()
        }
    }

    private func resetFields() {
        selectedCategory = ""
        budgetAmount = ""
    }

    private func deleteBudget(at offsets: IndexSet) {
        budgetManager.budgets.remove(atOffsets: offsets)
    }
}

struct BudgetSettingView_Previews: PreviewProvider {
    static var previews: some View {
        BudgetSettingView(budgetManager: BudgetManager())
            .environmentObject(CategoryManager())
    }
}

