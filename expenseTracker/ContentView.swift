//
//  ContentView.swift
//  expenseTracker
//
//  Created by Ananya Tandel on 10/23/23.
//

import SwiftUI

let budgetManager = BudgetManager()


struct ContentView: View {
    var body: some View {
        TabView {
            NavigationView {
                LogExpensesView() // Tab 1
            }
            .tabItem {
                Image(systemName: "square.and.pencil")
                Text("Log Expenses")
            }

            NavigationView {
                CategorizationView(budgetManager: BudgetManager()) // Tab 2 - Categorization
            }
            .tabItem {
                Image(systemName: "folder")
                Text("Categorization")
            }

            NavigationView {
                // Budget Setting tab view
                BudgetSettingView(budgetManager: BudgetManager())
            }
            .tabItem {
                Image(systemName: "dollarsign.square")
                Text("Budget Setting")
            }

            NavigationView {
                // Finances Quiz tab view
            }
            .tabItem {
                Image(systemName: "questionmark.square")
                Text("Finances Quiz")
            }
        }
        .accentColor(.pink) // Set the accent color to pink
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
