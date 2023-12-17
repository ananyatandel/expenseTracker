import SwiftUI

struct EditExpenseView: View {
    @Binding var expense: Expense
    var onSave: (Expense) -> Void

    @State private var editedName: String
    @State private var editedAmount: String
    @State private var editedDate: Date
    @State private var editedDescription: String
    @State private var editedCategory: String

    init(expense: Binding<Expense>, onSave: @escaping (Expense) -> Void) {
        self._expense = expense
        self.onSave = onSave

        _editedName = State(initialValue: expense.wrappedValue.name)
        _editedAmount = State(initialValue: expense.wrappedValue.amount)
        _editedDate = State(initialValue: expense.wrappedValue.date)
        _editedDescription = State(initialValue: expense.wrappedValue.description)
        _editedCategory = State(initialValue: expense.wrappedValue.category)
    }

    var body: some View {
        Form {
            TextField("Name", text: $editedName)
            TextField("Amount", text: $editedAmount)
            DatePicker("Date", selection: $editedDate)
            TextField("Description", text: $editedDescription)
            TextField("Category", text: $editedCategory)

            Button("Save") {
                let updatedExpense = Expense(
//                    id: expense.id,
                    name: editedName,
                    amount: editedAmount,
                    date: editedDate,
                    description: editedDescription,
                    category: editedCategory
                )
                onSave(updatedExpense)
            }
        }
        .navigationTitle("Edit Expense")
    }
}


//struct EditExpenseView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditExpenseView()
//    }
//}






//import SwiftUI
//
//struct EditExpenseView: View {
//    @Binding var expense: Expense
//    var onSave: (Expense) -> Void
//
//    @State private var editedName: String
//    @State private var editedAmount: String
//    @State private var editedDate: Date
//    @State private var editedDescription: String
//    @State private var editedCategory: String
//
//    init(expense: Binding<Expense>, onSave: @escaping (Expense) -> Void) {
//        self._expense = expense
//        self.onSave = onSave
//
//        _editedName = State(initialValue: expense.wrappedValue.name)
//        _editedAmount = State(initialValue: expense.wrappedValue.amount)
//        _editedDate = State(initialValue: expense.wrappedValue.date)
//        _editedDescription = State(initialValue: expense.wrappedValue.description)
//        _editedCategory = State(initialValue: expense.wrappedValue.category)
//    }
//
//    var body: some View {
//        Form {
//            TextField("Name", text: $editedName)
//            TextField("Amount", text: $editedAmount)
//            DatePicker("Date", selection: $editedDate, displayedComponents: .date)
//            TextField("Description", text: $editedDescription)
//            TextField("Category", text: $editedCategory)
//
//            Button("Save") {
//                let updatedExpense = Expense(
////                    id: expense.id,
//                    name: editedName,
//                    amount: editedAmount,
//                    date: editedDate,
//                    description: editedDescription,
//                    category: editedCategory
//                )
//                onSave(updatedExpense)
//            }
//        }
//        .navigationTitle("Edit Expense")
//    }
//}
//
//struct EditExpenseView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditExpenseView(
//            expense: .constant(Expense(name: "Sample", amount: "100", date: Date(), description: "Sample Description", category: "Misc")),
//            onSave: { _ in }
//        )
//    }
//}

