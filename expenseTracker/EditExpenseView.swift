import SwiftUI

// final commit message - ignore
struct EditExpenseView: View {
    @Binding var expense: Expense
    @State private var isAmountValid = true
    var onSave: (Expense) -> Void
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Expense Details").foregroundColor(.black)) {
                    TextField("Name", text: $expense.name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    TextField("Amount ($)", text: $expense.amount)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.decimalPad)
                        .onChange(of: expense.amount) { newValue in
                            isAmountValid = Double(newValue) != nil
                        }
                    
                    DatePicker("Date", selection: $expense.date, displayedComponents: .date)
                    
                    TextField("Description", text: $expense.description)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                Section {
                    Button("Save Changes") {
                        onSave(expense)
                    }
                    .disabled(!isAmountValid)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding()
                    .background(isAmountValid ? Color.green : Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
            }
            .navigationBarTitle("Edit Expense", displayMode: .inline)
        }
    }
}

struct EditExpenseView_Previews: PreviewProvider {
    static var previews: some View {
        EditExpenseView(expense: .constant(Expense(name: "Sample", amount: "100.00", date: Date(), description: "Sample", category: "Groceries")), onSave: { updatedExpense in })
    }
}

