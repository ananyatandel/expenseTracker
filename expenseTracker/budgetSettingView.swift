//// Budget Setting View
//// working with log expenses
//
//import SwiftUI
//
//struct BudgetSettingView: View {
//    @EnvironmentObject var categoryManager: CategoryManager
//    @ObservedObject var budgetManager: BudgetManager
//
//    @State private var selectedCategory: String = ""
//    @State private var budgetAmount: String = ""
//    @State private var selectedTimeFrame: TimeFrame = .weekly
//
//    var body: some View {
//        NavigationView {
//            Form {
//                Section(header: Text("Create Budget")) {
//                    Picker("Select Category", selection: $selectedCategory) {
//                        ForEach(categoryManager.categories, id: \.self) { category in
//                            Text(category).tag(category)
//                        }
//                    }
//
//                    TextField("Budget Amount", text: $budgetAmount)
//                        .keyboardType(.decimalPad)
//
//                    Picker("Time Frame", selection: $selectedTimeFrame) {
//                        ForEach(TimeFrame.allCases, id: \.self) { timeFrame in
//                            Text(timeFrame.rawValue).tag(timeFrame)
//                        }
//                    }
//                    .pickerStyle(SegmentedPickerStyle())
//
//                    Button("Set Budget") {
//                        setBudget()
//                    }
//                }
//
//                Section(header: Text("Current Budgets")) {
//                    List {
//                        ForEach(budgetManager.budgets) { budget in
//                            VStack(alignment: .leading) {
//                                Text(budget.category)
//                                    .font(.headline)
//                                Text("Amount: \(budget.amount, specifier: "%.2f")")
//                                Text("Time Frame: \(budget.timeFrame.rawValue)")
//                            }
//                        }
//                        .onDelete(perform: deleteBudget)
//                    }
//                }
//            }
//            .navigationBarTitle("Budget Settings", displayMode: .inline)
//            .background(
//            Image("quizBackground")
//                .resizable()
//                .aspectRatio(contentMode: .fill)
//                .edgesIgnoringSafeArea(.all)
//            )
//        }
//    }
//
//    private func setBudget() {
//        if let amount = Double(budgetAmount), !selectedCategory.isEmpty {
//            let newBudget = Budget(category: selectedCategory, amount: amount, timeFrame: selectedTimeFrame)
//            budgetManager.setBudget(newBudget)
//            resetFields()
//        }
//    }
//
//    private func resetFields() {
//        selectedCategory = ""
//        budgetAmount = ""
//    }
//
//    private func deleteBudget(at offsets: IndexSet) {
//        budgetManager.budgets.remove(atOffsets: offsets)
//    }
//}
//
//struct BudgetSettingView_Previews: PreviewProvider {
//    static var previews: some View {
//        BudgetSettingView(budgetManager: BudgetManager())
//            .environmentObject(CategoryManager())
//    }
//}
//

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
                // Background image
                Image("quizBackground")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)

                // Content
                ScrollView {
                    VStack(spacing: 20) {
                        Text("Budget Settings")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .padding(.top)

                        GroupBox {
                            Picker("Select Category", selection: $selectedCategory) {
                                ForEach(categoryManager.categories, id: \.self) { category in
                                    Text(category).tag(category)
                                }
                            }
                            .padding()

                            TextField("Budget Amount", text: $budgetAmount)
                                .keyboardType(.decimalPad)
                                .padding()

                            Picker("Time Frame", selection: $selectedTimeFrame) {
                                ForEach(TimeFrame.allCases, id: \.self) { timeFrame in
                                    Text(timeFrame.rawValue).tag(timeFrame)
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                            .padding()

                            Button("Set Budget") {
                                setBudget()
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.green)
                            .foregroundColor(Color.white)
                            .cornerRadius(10)
                        }
                        .background(Color.white.opacity(0.7))
                        .cornerRadius(10)
                        .padding()

                        GroupBox {
                            VStack(alignment: .leading) {
                                ForEach(budgetManager.budgets) { budget in
                                    HStack {
                                        VStack(alignment: .leading) {
                                            Text(budget.category)
                                                .font(.headline)
                                            Text("Amount: \(budget.amount, specifier: "%.2f")")
                                            Text("Time Frame: \(budget.timeFrame.rawValue)")
                                        }
                                        Spacer()
                                    }
                                    .padding()
                                    .background(Color.white)
                                    .cornerRadius(8)
                                    .shadow(radius: 4)
                                    .padding(.horizontal)
                                }
                                .onDelete(perform: deleteBudget)
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationBarTitle("Budget Settings", displayMode: .inline)
        }
    }

    private func setBudget() {
        if let amount = Double(budgetAmount), !selectedCategory.isEmpty, let timeframe = TimeFrame(rawValue: selectedTimeFrame.rawValue) {
            let newBudget = Budget(category: selectedCategory, amount: amount, timeFrame: timeframe)
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

struct BudgetSettingView_Previews: PreviewProvider {
    static var previews: some View {
        BudgetSettingView(budgetManager: BudgetManager())
            .environmentObject(CategoryManager())
    }
}

