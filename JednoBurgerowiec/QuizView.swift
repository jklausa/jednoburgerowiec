//
//  QuizView.swift
//  JednoBurgerowiec
//
//  Created by Jan Klausa on 05.07.20.
//

import SwiftUI
import Pages

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


                // https://iosdevelopers.slack.com/archives/CKA5E2RRC/p1594026027046700

            if shouldShowSummary {
                ResultView(score: score, numberOfQuestions: questionStates.count)
            } else {
                GeometryReader { geo in
                    ScrollView(.horizontal) {
                        LazyHStack {
                            ForEach(questionStates) { question in
                                QuestionView(question: questionBinding(for: question)) {
                                    advanceQuestion()
                                }.frame(width: geo.size.width)
                            }
                        }
                    }
                }
            }

            Text("Question \(String(index + 1)) / \(questionStates.count)")
                .foregroundColor(.red)
                .font(Font.subheadline
                        .bold()
                        .smallCaps())
        }
    }

    private func questionBinding(for question: QuestionState) -> Binding<QuestionState> {
        guard let index = questionStates.firstIndex(where: { $0.question == question.question} ) else {
            fatalError("whoops")
        }

        return $questionStates[index]
    }

    private func advanceQuestion() {
        guard index + 1 < questionStates.endIndex else {
            shouldShowSummary = true

            return
        }

        index = index + 1
    }

    var correctAnswerPercentageLabel: String {
        guard index != 0 else {
            return "0"
        }

        let fractionCorrect = Double(score) / Double(index)
        let percentageCorrect = fractionCorrect * 100

        return String(Int(percentageCorrect.rounded()))
    }

    var score: Int {
        questionStates.lazy.filter { $0.answeredCorrectly }.count
    }
}

struct QuestionState: Identifiable {
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
