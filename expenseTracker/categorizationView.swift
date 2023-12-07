
import SwiftUI

struct Category: Identifiable {
    let id = UUID()
    let name: String
}

struct CategorizationView: View {
    @ObservedObject var budgetManager: BudgetManager

    init(budgetManager: BudgetManager) {
        self.budgetManager = budgetManager
    }

    @State private var categories: [Category] = []
    @State private var categoryName: String = ""
    @State private var selectedCategory: String?

    var allCategories: [String] {
        return categories.map { $0.name } + budgetManager.budgets.map { $0.category }
    }

    var isCategoryNameValid: Bool {
        return !categoryName.trimmingCharacters(in: .whitespaces).isEmpty
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
                                guard isCategoryNameValid else {
                                    return
                                }

                                let newCategory = Category(name: categoryName)
                                categories.append(newCategory)
                                categoryName = ""
                            }
                            .foregroundColor(.white)
                            .padding()
                            .background(isCategoryNameValid ? Color.green : Color.orange)
                            .cornerRadius(8.0)
                            .padding()

                            List {
                                ForEach(categories) { category in
                                    HStack {
                                        Text(category.name)
                                            .font(.headline)
                                            .foregroundColor(.blue)
                                        Spacer()
                                        Button(action: {
                                            deleteCategory(category)
                                        }) {
                                            Image(systemName: "trash")
                                                .foregroundColor(.red)
                                        }
                                    }
                                }
                                .onDelete(perform: deleteCategories)
                            }
                            .listStyle(PlainListStyle())
                        }
                        .cornerRadius(15)
                        .padding()
                    )
            }
            .navigationBarHidden(true)
        }
    }

    private func deleteCategory(_ category: Category) {
        guard let index = categories.firstIndex(where: { $0.id == category.id }) else {
            return
        }
        categories.remove(at: index)
    }

    private func deleteCategories(at offsets: IndexSet) {
        categories.remove(atOffsets: offsets)
    }
}

struct CategorizationView_Previews: PreviewProvider {
    static var previews: some View {
        CategorizationView(budgetManager: BudgetManager())
    }
}
