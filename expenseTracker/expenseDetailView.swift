

import SwiftUI



struct ExpenseDetailView: View {
    let expense: Expense
    @State private var isEditing = false

    var body: some View {
        VStack {
            Text("Expense Details")
                .font(.title)
                .padding()
                .background(Color("LightBlue"))

            Text("Name: \(expense.name)")
                .padding()
                .font(.title2)
                .foregroundColor(Color("DarkBlue"))

            Text("Amount: \(expense.amount)")
                .padding()
                .font(.headline)
            Text("Date: \(formattedDate)")
                .padding()
                .font(.subheadline)

            Text("Description: \(expense.description)")
                .padding()
                .font(.body)

            VStack {
                Button("Edit") {
                    isEditing = true
                }
                .foregroundColor(.blue)
                .padding()
                .padding()

//                Button("Delete") {
//                    // code to delete the expense
//                    // Remove the expense from the expenses array
////                    onDelete?()
//                }
//                .foregroundColor(.red)
            }
        }
        .background(Color("Yellow"))
        .navigationTitle("Expense Details")
        .sheet(isPresented: $isEditing) {
            // implement edit view (still a work in progress)
        }
    }

    var formattedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: expense.date)
    }
}



struct ExpenseDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ExpenseDetailView(expense: Expense(name: "Sample Expense", amount: "100.00", date: Date(), description: "Test"))

    }
}

