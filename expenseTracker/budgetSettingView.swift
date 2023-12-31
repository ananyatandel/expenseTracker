// Budget Setting View
// working with log expenses and categorization

import SwiftUI

struct BudgetSettingView: View {
    @EnvironmentObject var categoryManager: CategoryManager
    @ObservedObject var budgetManager: BudgetManager

    @State private var selectedCategory: String = ""
    @State private var budgetAmount: String = ""
    @State private var selectedTimeFrame: TimeFrame = .weekly

    var body: some View {
        NavigationView {
            ZStack {
                Image("gradient")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)

                ScrollView {
                    VStack(spacing: 20) {
                        Text("Budget Settings")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .padding(.top, 50)
                            .foregroundColor(.black)

                        VStack(alignment: .leading, spacing: 10) {
                            HStack {
                                Text("Select Category")
                                    .foregroundColor(.black)
                                    .padding(.leading, 10)
                                Spacer()
                                Picker("Select Category", selection: $selectedCategory) {
                                    ForEach(categoryManager.categories, id: \.self) { category in
                                        Text(category).tag(category)
                                    }
                                }
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .pickerStyle(MenuPickerStyle())

                            TextField("Budget Amount", text: $budgetAmount)
                                .keyboardType(.decimalPad)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(10)

                            CustomSegmentedControl(selectedTimeFrame: $selectedTimeFrame)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(10)

                            Button("Set Budget") {
                                setBudget()
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.green)
                            .foregroundColor(Color.white)
                            .cornerRadius(10)
                        }
                        .padding(.horizontal)

                        VStack(alignment: .leading, spacing: 10) {
                            Text("Current Budgets")
                                .font(.headline)
                                .padding(.leading, 10)

                            ForEach(budgetManager.budgets) { budget in
                                BudgetRow(budget: budget)
                            }
                            .onDelete(perform: deleteBudget)
                        }
                        .padding(.horizontal, 15)
                    }
                }
            }
            .navigationBarTitle("", displayMode: .inline)
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
        selectedTimeFrame = .weekly
    }

    private func deleteBudget(at offsets: IndexSet) {
        budgetManager.budgets.remove(atOffsets: offsets)
    }
}

struct CustomSegmentedControl: View {
    @Binding var selectedTimeFrame: TimeFrame

    var body: some View {
        HStack {
            ForEach(TimeFrame.allCases, id: \.self) { timeFrame in
                Text(timeFrame.rawValue)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(self.selectedTimeFrame == timeFrame ? Color.blue : Color.gray)
                    .foregroundColor(Color.white)
                    .cornerRadius(15)
                    .onTapGesture {
                        self.selectedTimeFrame = timeFrame
                    }
            }
        }
    }
}

struct BudgetRow: View {
    let budget: Budget

    var body: some View {
        VStack(alignment: .leading) {
            Text(budget.category)
                .font(.headline)
            Text("Amount: \(budget.amount, specifier: "%.2f")")
            Text("Time Frame: \(budget.timeFrame.rawValue)")
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white)
        .cornerRadius(8)
        .shadow(radius: 4)
    }
}

struct BudgetSettingView_Previews: PreviewProvider {
    static var previews: some View {
        BudgetSettingView(budgetManager: BudgetManager())
            .environmentObject(CategoryManager())
    }
}

// final commit message - ignore
