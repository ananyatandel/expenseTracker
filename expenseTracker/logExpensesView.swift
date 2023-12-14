// without swipe to delete
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
    @State private var expenseCategories = ["Groceries", "Transportation", "Entertainment", "Housing", "Insurance", "Misc"]
    @State private var selectedCategory: String?
    @State private var customCategoryName = ""

    var body: some View {

        ZStack {
            // Background Image
            Image("dollarBill")
//                .resizable()
//                .scaledToFill()
//                .edgesIgnoringSafeArea(.all)
                .opacity(1.0) // Make it fully opaque

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

                    Button("Add Expense") {
                        _ = selectedCategory ?? customCategoryName

                        let newExpense = Expense(name: expenseName, amount: expenseAmount, date: expenseDate, description: expenseDescription)
                        expenses.append(newExpense)
                        expenseName = ""
                        expenseAmount = ""
                        expenseDate = Date()
                        expenseDescription = ""
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
}

struct LogExpensesView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}






// updated code with swipe to delete feature - but it's not loading in simulator at all and there are no errors showing up
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
//    @State private var customCategoryName = ""
//
//    var body: some View {
//        ZStack {
//            // Background Image
//            Image("dollarBill")
//                .resizable()
//                .scaledToFill()
//                .edgesIgnoringSafeArea(.all)
//                .opacity(1.0) // Make it fully opaque
//
//            Form {
//                Section(header: Text("Log an Expense")) {
//                    TextField("Expense Name", text: $expenseName)
//                    TextField("Expense Amount ($)", text: $expenseAmount)
//                        .keyboardType(.numberPad)
//                    DatePicker("Expense Date", selection: $expenseDate)
//                    TextField("Expense Description", text: $expenseDescription)
//                    Picker("Select Category", selection: $selectedCategory) {
//                        ForEach(expenseCategories, id: \.self) { category in
//                            Text(category)
//                        }
//                    }
//                    .pickerStyle(MenuPickerStyle())
//
//                    Button("Add Expense") {
//                        _ = selectedCategory ?? customCategoryName
//
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
//                        .onDelete { indices in
//                            deleteExpenses(at: indices)
//                        }
//                    }
//                }
//            }
//        }
//    }
//
//    private func deleteExpenses(at indices: IndexSet) {
//        expenses.remove(atOffsets: indices)
//    }
//}
//
//struct LogExpensesView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
