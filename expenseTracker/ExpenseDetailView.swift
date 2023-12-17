
// ExpenseDetailView.swift

import SwiftUI

struct ExpenseDetailView: View {
    let expense: Expense
    @State private var isEditing = false
    @State private var showingDeleteAlert = false
    var onDelete: (() -> Void)?

    var body: some View {
        ZStack {
            Image("dollarCoin")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)

            VStack {
                VStack(alignment: .center, spacing: 10) {
                    Text("Details")
                        .font(.title)
                        .padding(.bottom, 5)

                    Text("Name: \(expense.name)")
                        .padding()
                    Text("Amount: $\(expense.amount)")
                        .padding()
                    Text("Date: \(formattedDate)")
                        .padding()
                    Text("Description: \(expense.description)")
                        .padding()
                    Text("Category: \(expense.category)")
                        .padding()
                }
                .padding()
                .font(.body)
                .multilineTextAlignment(.center)
                .background(RoundedRectangle(cornerRadius: 20).fill(Color.yellow))
                .padding(.horizontal, 50) // Increase card size

                VStack(spacing: 10) {
                    Button("Edit") {
                        isEditing = true
                    }
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)

                    Button("Delete") {
                        showingDeleteAlert = true
                    }
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.red)
                    .cornerRadius(10)
                }
                .padding(.top, 10)
            }
            .padding(.top, 20) 
        }
        .navigationTitle("Expense Details")
        .alert(isPresented: $showingDeleteAlert) {
            Alert(
                title: Text("Delete Expense"),
                message: Text("Are you sure you want to delete this expense?"),
                primaryButton: .destructive(Text("Delete")) {
                    onDelete?()
                },
                secondaryButton: .cancel()
            )
        }
        .sheet(isPresented: $isEditing) {
            // Implement edit view
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
        ExpenseDetailView(
            expense: Expense(name: "Sample Expense", amount: "100.00", date: Date(), description: "Sample text", category: "Groceries"),
            onDelete: {} // onDelete closure for preview
        )
    }
}


