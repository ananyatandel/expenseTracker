//
//  expenseDetailView.swift
//  expenseTracker
//
//  Created by Ananya Tandel on 10/25/23.
//

import SwiftUI

//struct ExpenseDetailView: View {
//    let expense: Expense
//    @State private var isEditing = false
//
//    var body: some View {
//        VStack {
//
//            Text("Expense Details")
//                .font(.title)
//                .padding()
//            Text("Name: \(expense.name)")
//                .padding()
//            Text("Amount: \(expense.amount)")
//                .padding()
//            Text("Date: \(formattedDate)")
//                .padding()
//            Text("Description: \(expense.description)")
//                .padding()
//                .padding()
//
//            VStack {
//                Button("Edit") {
//                    isEditing = true
//                }
//                .foregroundColor(.blue)
//                .padding()
//                .padding()
//                Button("Delete") {
//                    // code to delete the expense
//                    // Remove the expense from the expenses array
//                }
//                .foregroundColor(.red)
//            }
//        }
//        .navigationTitle("Expense Details")
//        .sheet(isPresented: $isEditing) {
//            // implement edit view (still a owrk in progress)
//        }
//    }
//
//    var formattedDate: String {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateStyle = .medium
//        return dateFormatter.string(from: expense.date)
//    }
//}

struct ExpenseDetailView: View {
    let expense: Expense
    @State private var isEditing = false

    var body: some View {
        VStack {
            Text("Expense Details")
                .font(.title)
                .padding()
                .background(Color("LightBlue")) // Set the background color to light blue

            Text("Name: \(expense.name)")
                .padding()
                .font(.title2) // Change the font size
                .foregroundColor(Color("DarkBlue")) // Change the font color

            Text("Amount: \(expense.amount)")
                .padding()
                .font(.headline) // Change the font size

            Text("Date: \(formattedDate)")
                .padding()
                .font(.subheadline) // Change the font size

            Text("Description: \(expense.description)")
                .padding()
                .font(.body) // Change the font size

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
        .background(Color("LightBlue")) // Set the overall background color to light blue
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

