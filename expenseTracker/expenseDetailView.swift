//
//  expenseDetailView.swift
//  expenseTracker
//
//  Created by Ananya Tandel on 10/25/23.
//

import SwiftUI

struct ExpenseDetailView: View {
    let expense: Expense
    @State private var isEditing = false

    var body: some View {
        VStack {
         
            Text("Expense Details")
                .font(.title)
                .padding()
            Text("Name: \(expense.name)")
                .padding()
            Text("Amount: \(expense.amount)")
                .padding()
            Text("Date: \(formattedDate)")
                .padding()
            Text("Description: \(expense.description)")
                .padding()
                .padding()

            VStack {
                Button("Edit") {
                    isEditing = true
                }
                .foregroundColor(.blue)
                .padding()
                .padding()
                Button("Delete") {
                    // code to delete the expense
                    // Remove the expense from the expenses array
                }
                .foregroundColor(.red)
            }
        }
        .navigationTitle("Expense Details")
        .sheet(isPresented: $isEditing) {
            // implement edit view (still a owrk in progress)
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

