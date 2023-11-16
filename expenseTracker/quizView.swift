//
//  quizView.swift
//  expenseTracker
//
//  Created by Ananya Tandel on 11/13/23.
//

import SwiftUI

struct QuizQuestion: Identifiable {
    let id = UUID()
    let question: String
    let options: [String]
    let correctAnswer: String
}

struct QuizView: View {
    @State private var currentQuestionIndex = 0
    @State private var selectedAnswer: String?
    @State private var score = 0
    
    let quizQuestions: [QuizQuestion] = [
        QuizQuestion(question: "What is the purpose of a budget?", options: ["Save money", "Spend money", "Track income and expenses"], correctAnswer: "Track income and expenses"),
        QuizQuestion(question: "What is the definition of compound interest?", options: ["Interest calculated on the initial principal", "Interest calculated on both the initial principal and the accumulated interest", "Interest paid monthly"], correctAnswer: "Interest calculated on both the initial principal and the accumulated interest"),
        QuizQuestion(question: "What does ROI stand for?", options: ["Return on Investment", "Rate of Interest", "Risk of Inflation"], correctAnswer: "Return on Investment"),
        QuizQuestion(question: "What is the 50/30/20 rule in budgeting?", options: ["Percentage allocation for savings, expenses, and investments", "Rule for credit card payments", "Budgeting every 50 days, 30 days, and 20 days"], correctAnswer: "Percentage allocation for savings, expenses, and investments"),
        QuizQuestion(question: "What is a 401(k)?", options: ["A type of budgeting software", "A retirement savings plan", "A credit score"], correctAnswer: "A retirement savings plan"),
        QuizQuestion(question: "What is a stock?", options: ["A type of investment that represents ownership in a company", "A type of budgeting category", "A financial penalty"], correctAnswer: "A type of investment that represents ownership in a company"),
        QuizQuestion(question: "What is the meaning of the term 'dividend'?", options: ["A tax deduction", "A portion of a company's profits paid to shareholders", "A type of expense"], correctAnswer: "A portion of a company's profits paid to shareholders"),
        QuizQuestion(question: "What is an emergency fund?", options: ["A fund for planned expenses", "A savings fund for unexpected expenses", "A retirement fund"], correctAnswer: "A savings fund for unexpected expenses"),
        QuizQuestion(question: "What is a credit score used for?", options: ["Determining eligibility for loans and credit cards", "Measuring your income", "Calculating your savings"], correctAnswer: "Determining eligibility for loans and credit cards"),
        QuizQuestion(question: "What does APR stand for?", options: ["Average Percentage Rate", "Annual Percentage Rate", "Advanced Personal Record"], correctAnswer: "Annual Percentage Rate"),
    ]
    
    var body: some View {
//        ZStack {
//            // Background Image
//            Image("download")
//                .resizable()
//                .scaledToFill()
//                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                
                if currentQuestionIndex < quizQuestions.count {
                    QuizQuestionView(question: quizQuestions[currentQuestionIndex], selectedAnswer: $selectedAnswer)
                        .padding()
                } else {
                    QuizResultView(score: score, totalQuestions: quizQuestions.count)
                        .padding()
                }
                
                Spacer()
                
                if currentQuestionIndex < quizQuestions.count {
                    Button("Next Question") {
                        checkAnswer()
                        currentQuestionIndex += 1
                        selectedAnswer = nil
                    }
                    .padding()
                    .disabled(selectedAnswer == nil)
                } else {
                    Button("Restart Quiz") {
                        currentQuestionIndex = 0
                        score = 0
                        selectedAnswer = nil
                    }
                    .padding()
                }
                Spacer()
            }
            .navigationTitle("Financial Quiz")
        }
        
        private func checkAnswer() {
            if let selectedAnswer = selectedAnswer,
               selectedAnswer == quizQuestions[currentQuestionIndex].correctAnswer {
                score += 1
            }
        }
    }

// plain question view
//struct QuizQuestionView: View {
//    let question: QuizQuestion
//    @Binding var selectedAnswer: String?
//
//    var body: some View {
//        VStack(alignment: .leading) {
//            Text(question.question)
//                .font(.headline)
//                .padding(.bottom, 10)
//
//            ForEach(question.options, id: \.self) { option in
//                Button(action: {
//                    selectedAnswer = option
//                }) {
//                    HStack {
//                        Image(systemName: selectedAnswer == option ? "checkmark.circle.fill" : "circle")
//                        Text(option)
//                    }
//                }
//                .buttonStyle(PlainButtonStyle())
//                .padding(.vertical, 5)
//            }
//        }
//    }
//}

struct QuizQuestionView: View {
    let question: QuizQuestion
    @Binding var selectedAnswer: String?
    
    var body: some View {
     
            
        VStack {
                Text(question.question)
                    .font(.title)
                    .padding()
                    .padding()
                
                ForEach(question.options, id: \.self) { option in
                    Button(action: {
                        selectedAnswer = option
                    }) {
                        HStack {
                            Image(systemName: selectedAnswer == option ? "checkmark.circle.fill" : "circle")
                                .foregroundColor(.white)
                            Text(option)
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                    .padding(.vertical, 10)
                    .padding(.horizontal, 10)
                    .background(selectedAnswer == option ? Color.purple : Color.pink)
                    .cornerRadius(15)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(selectedAnswer == option ? Color.purple : Color.pink, lineWidth: 1)
                    )
                    .padding(.horizontal, 10)
                }
            }
            .padding()
            .background(Color.white.opacity(0.8))
            .cornerRadius(20)
            .padding(.horizontal, 20)
            .shadow(radius: 5)
        }
    }


struct QuizResultView: View {
    let score: Int
    let totalQuestions: Int

    var body: some View {
        VStack {
            Text("Quiz Completed!")
                .font(.title)
                .padding()

            Text("Your Score: \(score) / \(totalQuestions)")
                .font(.headline)
                .padding()

            Text("Feedback: \(feedbackMessage)")
                .padding()
        }
    }

    private var feedbackMessage: String {
        let percentage = Double(score) / Double(totalQuestions) * 100
        if percentage >= 70 {
            return "Great job! You have a good understanding of financial terms."
        } else {
            return "Keep learning! Consider reviewing financial terms to enhance your knowledge."
        }
    }
}

struct QuizView_Previews: PreviewProvider {
    static var previews: some View {
        QuizView()
    }
}

