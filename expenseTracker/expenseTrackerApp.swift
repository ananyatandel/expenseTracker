//
//  expenseTrackerApp.swift
//  expenseTracker
//
//  Created by Ananya Tandel on 10/26/23.
//

import SwiftUI

@main
struct expenseTrackerApp: App {
    let persistenceController = PersistenceController.shared
    var budgetManager = BudgetManager()
    var categoryManager = CategoryManager()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(categoryManager)
                .environmentObject(budgetManager)
        }
    }
}

