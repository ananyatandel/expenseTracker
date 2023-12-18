//
//  CategorizationView.swift
//  concurrently working with LogExpensesView

import SwiftUI

struct Category: Identifiable {
    let id = UUID()
    let name: String
}

struct CategorizationView: View {
    @ObservedObject var budgetManager: BudgetManager
    @EnvironmentObject var categoryManager: CategoryManager
    @State private var categoryName: String = ""
    
    var isCategoryNameValid: Bool {
        !categoryName.trimmingCharacters(in: .whitespaces).isEmpty
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Image("logExpensesBackground")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                    .overlay(
                        VStack {
                            Text("Manage Categories")
                                .font(.largeTitle)
                                .foregroundColor(.black)
                                .padding()
                            TextField("Enter Custom Category", text: $categoryName)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding()
                                .foregroundColor(.black)
                            Button("Add Category") {
                                guard isCategoryNameValid else { return }
                                categoryManager.addCategory(categoryName)
                                categoryName = ""
                            }
                            .foregroundColor(.white)
                            .padding()
                            .background(isCategoryNameValid ? Color.green : Color.orange)
                            .cornerRadius(8.0)
                            .padding()
                            List(categoryManager.categories, id: \.self) { category in
                                Text(category)
                                    .font(.headline)
                                    .foregroundColor(.black)
                                    .padding()
                                    .listRowBackground(Color.white) // background of each row is white
                                
                                    .listRowInsets(EdgeInsets()) // remove default padding and separators
                            }
                            .listStyle(PlainListStyle()) // Remove extra padding and separators
                        }
                        .cornerRadius(15)
                        .padding()
                    )
            }
            .navigationBarHidden(true)
        }
    }
}

struct CategorizationView_Previews: PreviewProvider {
    static var previews: some View {
        CategorizationView(budgetManager: BudgetManager())
            .environmentObject(CategoryManager())
    }
}

// final commit message - ignore
