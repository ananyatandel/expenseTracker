//
//  ContentView.swift
//  expenseTracker
//
//  Created by Ananya Tandel on 10/23/23.
//

import SwiftUI

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
                // add views here for other tabs
            }
            .tabItem {
                Image(systemName: "folder")
                Text("Categorization")
            }

            NavigationView {
                // Budget Setting tab view
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
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

