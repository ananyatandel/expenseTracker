//// LogExpensesView.swift
//// concurrently working with categories
//
//import SwiftUI
//
//struct Expense: Identifiable {
//    let id = UUID()
//    var name: String
//    var amount: String
//    var date: Date
//    var description: String
//    var category: String
//}
//// test commit comment
//
//struct LogExpensesView: View {
//    @EnvironmentObject var categoryManager: CategoryManager
//    @State private var expenseName = ""
//    @State private var expenseAmount = ""
//    @State private var expenseDate = Date()
//    @State private var expenseDescription = ""
//    @State private var expenses: [Expense] = []
//    @State private var selectedCategory = "Groceries"
//
//    var body: some View {
//        NavigationView {
//            ZStack {
//                Image("budgetBackground")
//                    .resizable()
//                    .aspectRatio(contentMode: .fill)
//                    .edgesIgnoringSafeArea(.all)
//
//                ScrollView {
//                    VStack(alignment: .center, spacing: 20) {
//                        Text("Log An Expense")
//                            .font(.largeTitle)
//                            .fontWeight(.bold)
//                            .padding(.top, 50)
//                            .foregroundColor(.white)
//
//                        VStack(alignment: .leading, spacing: 10) {
//                            TextField("Expense Name", text: $expenseName)
//                                .padding()
//                                .background(Color.white)
//                                .cornerRadius(10)
//                            TextField("Expense Amount ($)", text: $expenseAmount)
//                                .padding()
//                                .background(Color.white)
//                                .cornerRadius(10)
//                                .keyboardType(.numberPad)
//                            DatePicker("Expense Date", selection: $expenseDate, displayedComponents: .date)
//                                .padding()
//                                .background(Color.white)
//                                .cornerRadius(10)
//
//                            TextField("Expense Description (Optional)", text: $expenseDescription)
//                                .padding()
//                                .background(Color.white)
//                                .cornerRadius(10)
//
//                            HStack {
//                                Text("Select Category")
//                                    .foregroundColor(Color.black)
//                                Spacer()
//                                Picker("Select Category", selection: $selectedCategory) {
//                                    ForEach(categoryManager.categories, id: \.self) { category in
//                                        Text(category).tag(category)
//                                    }
//                                }
//                                .pickerStyle(MenuPickerStyle())
//                                .foregroundColor(Color.black)
//                            }
//                            .padding()
//                            .background(Color.white)
//                            .cornerRadius(10)
//
//                            Button("Add Expense") {
//                                if !expenseName.isEmpty && !expenseAmount.isEmpty {
//                                    let newExpense = Expense(name: expenseName, amount: expenseAmount, date: expenseDate, description: expenseDescription, category: selectedCategory)
//                                    expenses.append(newExpense)
//                                    resetExpenseFields()
//                                }
//                            }
//                            .frame(maxWidth: .infinity)
//                            .padding()
//                            .background(Color.green)
//                            .foregroundColor(Color.white)
//                            .cornerRadius(15)
//                        }
//                        .padding(.horizontal)
//
//                        Spacer().frame(height: 30)
//
//                        VStack(alignment: .leading, spacing: 10) {
//                            ForEach(expenses) { expense in
//                                NavigationLink(destination: ExpenseDetailView(expense: expense)) {
//                                    VStack(alignment: .leading) {
//                                        Text(expense.name).font(.headline).foregroundColor(Color.black)
//                                        Text(expense.amount).font(.subheadline).foregroundColor(Color.black)
//                                    }
//                                    .frame(maxWidth: .infinity, alignment: .leading)
//                                    .padding()
//                                    .background(Color.white)
//                                    .cornerRadius(10)
//                                    .padding(.horizontal, 8)
//                                }
//                            }
//                            .onDelete(perform: deleteExpense)
//                        }
//                    }
//                }
//            }
//            .accentColor(Color.green)
//            .navigationBarTitle("", displayMode: .inline)
//            .navigationBarHidden(true)
//        }
//    }
//
//    private func deleteExpense(at offsets: IndexSet) {
//        expenses.remove(atOffsets: offsets)
//    }
//
//    private func resetExpenseFields() {
//        expenseName = ""
//        expenseAmount = ""
//        expenseDate = Date()
//        expenseDescription = ""
//    }
//}
//
//struct LogExpensesView_Previews: PreviewProvider {
//    static var previews: some View {
//        LogExpensesView()
//            .environmentObject(CategoryManager())
//    }
//}

import SwiftUI

struct Expense: Identifiable {
    let id = UUID()
    var name: String
    var amount: String
    var date: Date
    var description: String
    var category: String
}

struct LogExpensesView: View {
    @EnvironmentObject var categoryManager: CategoryManager
    @ObservedObject var budgetManager: BudgetManager
    @State private var expenseName = ""
    @State private var expenseAmount = ""
    @State private var expenseDate = Date()
    @State private var expenseDescription = ""
    @State private var expenses: [Expense] = []
    @State private var selectedCategory = "Groceries"
    @State private var showingBudgetAlert = false
    @State private var alertMessage = ""
    var body: some View {
        NavigationView {
            ZStack {
                Image("budgetBackground") // Replace with your actual background image name
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)
                ScrollView {
                    VStack(alignment: .center, spacing: 20) {
                        Text("Log An Expense")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .padding(.top, 50)
                            .foregroundColor(.white)
                        VStack(alignment: .leading, spacing: 10) {
                            TextField("Expense Name", text: $expenseName)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(10)
                            TextField("Expense Amount ($)", text: $expenseAmount)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(10)
                                .keyboardType(.numberPad)
                            DatePicker("Expense Date", selection: $expenseDate, displayedComponents: .date)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(10)
                            TextField("Expense Description", text: $expenseDescription)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(10)
                            HStack {
                                Text("Select Category")
                                    .foregroundColor(Color.black)
                                Spacer()
                                Picker("Select Category", selection: $selectedCategory) {
                                    ForEach(categoryManager.categories, id: \.self) { category in
                                        Text(category).tag(category)
                                    }
                                }
                                .pickerStyle(MenuPickerStyle())
                                .foregroundColor(Color.black)
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            Button("Add Expense") {
                                addExpense()
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(Color.white)
                            .cornerRadius(15)
                        }
                        .padding(.horizontal)
                        Spacer().frame(height: 30)
                        VStack(alignment: .leading, spacing: 10) {
                            ForEach(expenses) { expense in
                                NavigationLink(destination: ExpenseDetailView(expense: expense)) {
                                    VStack(alignment: .leading) {
                                        Text(expense.name).font(.headline).foregroundColor(Color.black)
                                        Text(expense.amount).font(.subheadline).foregroundColor(Color.black)
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding()
                                    .background(Color.white)
                                    .cornerRadius(10)
                                    .padding(.horizontal, 8)
                                }
                            }
                            .onDelete(perform: deleteExpense)
                        }
                    }
                }
            }
            .alert(isPresented: $showingBudgetAlert) {
                Alert(title: Text("Budget Alert"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarHidden(true)
        }
    }
    
    private func addExpense() {
        if !expenseName.isEmpty && !expenseAmount.isEmpty {
            let exceedsBudget = self.exceedsBudget(category: selectedCategory, amount: Double(expenseAmount) ?? 0)
            let newExpense = Expense(name: expenseName, amount: expenseAmount, date: expenseDate, description: expenseDescription, category: selectedCategory)
            expenses.append(newExpense)
            resetExpenseFields()
            if exceedsBudget {
                alertMessage = "This expense exceeds your set budget for \(selectedCategory)."
                showingBudgetAlert = true
            }
        }
    }
    private func deleteExpense(at offsets: IndexSet) {
        expenses.remove(atOffsets: offsets)
    }
    private func resetExpenseFields() {
        expenseName = ""
        expenseAmount = ""
        expenseDate = Date()
        expenseDescription = ""
    }
    private func exceedsBudget(category: String, amount: Double) -> Bool {
        if let budget = budgetManager.budgets.first(where: { $0.category == category }) {
            return amount > budget.amount
        }
        return false
    }
}


struct LogExpensesView_Previews: PreviewProvider {
    static var previews: some View {
        LogExpensesView(budgetManager: BudgetManager())
            .environmentObject(CategoryManager())
    }
}

