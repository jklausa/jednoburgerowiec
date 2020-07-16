//
//  QuizView.swift
//  JednoBurgerowiec
//
//  Created by Jan Klausa on 05.07.20.
//

import SwiftUI

struct QuizView: View {

    init(questions: [Question]) {
        _questionStates = State(initialValue: questions.map { QuestionState(question: $0) })
    }

    @State var questionStates: [QuestionState]

    @State private var index: Int = 0
    @State private var shouldShowSummary: Bool = false

    var body: some View {
        VStack {
            Text("\(String(score)) answered correctly, \(correctAnswerPercentageLabel)%")
                .foregroundColor(.yellow)
                .font(Font.subheadline
                        .bold()
                        .smallCaps())

            if shouldShowSummary {
                ResultView(score: score, numberOfQuestions: questionStates.count)
            } else {

                TabView(selection: $index) {

                    ForEach(Array(questionStates.enumerated()), id: \.element) { pageIndex, _ in

                        QuestionView(question: $questionStates[pageIndex]) {
                            advanceQuestion()
                        }
                        .tag(pageIndex)

                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            }

            Text("Question \(String(index + 1)) / \(questionStates.count)")
                .foregroundColor(.red)
                .font(Font.subheadline
                        .bold()
                        .smallCaps())
        }
    }

    private func advanceQuestion() {
        guard index + 1 < questionStates.endIndex else {
            shouldShowSummary = true

            return
        }

        withAnimation {
            index = index + 1
        }
    }

    var correctAnswerPercentageLabel: String {
        let questionsAnswered = questionStates.lazy.filter { $0.answered }.count

        guard questionsAnswered > 0 else {
            return "0"
        }

        let fractionCorrect = Double(score) / Double(questionsAnswered)
        let percentageCorrect = fractionCorrect * 100

        return String(Int(percentageCorrect.rounded()))
    }

    var score: Int {
        questionStates.lazy.filter { $0.answeredCorrectly }.count
    }
}

struct QuestionState: Identifiable, Hashable {
    let question: String

    let answers: [String]
    let correctAnswerIndex: Int

    var pickedIndex: Int?

    var id: String { question }

    init(question: Question) {
        self.question = question.text
        self.answers = question.answers.shuffled()
        self.correctAnswerIndex = answers.firstIndex(of: question.answers[question.correctAnswerIndex])!

        self.pickedIndex = nil
    }

    mutating func answer(index: Int) {
        pickedIndex = index
    }

    var answeredCorrectly: Bool {
        guard answered else {
            return false
        }

        return pickedIndex == correctAnswerIndex
    }

    var answered: Bool {
        pickedIndex != nil
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
