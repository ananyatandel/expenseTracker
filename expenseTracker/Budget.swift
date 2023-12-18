//
//  Budget.swift
//  expenseTracker

import Foundation

struct Budget: Identifiable, Codable {
    var id = UUID()
    let category: String
    var amount: Double
    var timeFrame: TimeFrame
}

enum TimeFrame: String, Codable, CaseIterable {
    case weekly = "Weekly"
    case monthly = "Monthly"
}
