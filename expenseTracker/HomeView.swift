//
//  HomeView.swift
//  expenseTracker

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            VStack {
                Spacer()

                HStack {
                    Spacer()
                    NavigationLink(destination: LogExpensesView(budgetManager: BudgetManager())) {
                        CircularButton(systemImageName: "square.and.pencil", text: "Log Expenses")
                    }
                    Spacer()
                    NavigationLink(destination: CategorizationView(budgetManager: BudgetManager())) {
                        CircularButton(systemImageName: "folder", text: "Categorization")
                    }
                    Spacer()
                }

                Spacer()

                HStack {
                    Spacer()
                    NavigationLink(destination: BudgetSettingView(budgetManager: BudgetManager())) {
                        CircularButton(systemImageName: "dollarsign.square", text: "Budget Setting")
                    }
                    Spacer()
                    NavigationLink(destination: QuizView()) {
                        CircularButton(systemImageName: "questionmark.square", text: "Finances Quiz")
                    }
                    Spacer()
                }

                Spacer()
            }
            .background(
                Image("homeBackground")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
            )
            .navigationTitle("🏠")
        }
    }
}

struct CircularButton: View {
    let systemImageName: String
    let text: String

    var body: some View {
        VStack {
            Image(systemName: systemImageName)
                .font(.system(size: 50))
                .foregroundColor(.black)
                .padding()
                .padding()
                .background(Color.white)
                .clipShape(Circle())
            
            Text(text)
                .foregroundColor(.black)
                .font(.system(size: 20))
                .padding()
                .font(.caption)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

