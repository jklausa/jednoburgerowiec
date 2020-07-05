//
//  QuizView.swift
//  JednoBurgerowiec
//
//  Created by Jan Klausa on 05.07.20.
//

import SwiftUI

struct QuizView: View {

    let questions: [Question]

    @State private var score: Int = 0
    @State private var index: Int = 0

    var body: some View {
        VStack {
            Text("\(String(score)) answered correctly, \(correctAnswerPercentageLabel)%")
                .foregroundColor(.yellow)
                .font(Font.subheadline
                        .bold()
                        .smallCaps())

            QuestionView(question: questions[index]) { correct in
                if correct {
                    score = score + 1
                }

                index = index + 1
            }

            Text("Question \(String(index + 1)) / \(questions.count)")
                .foregroundColor(.red)
                .font(Font.subheadline
                        .bold()
                        .smallCaps())
        }
    }

    var correctAnswerPercentageLabel: String {
        guard index != 0 else {
            return "0"
        }

        let fractionCorrect = Double(score) / Double(index)
        let percentageCorrect = fractionCorrect * 100

        return String(Int(percentageCorrect.rounded()))
    }
}

struct QuizView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            QuizView(questions: Array(Question.allQuestions().prefix(33)))
            QuizView(questions: Question.allQuestions())
                .previewDevice("iPhone 8")
        }
    }
}
