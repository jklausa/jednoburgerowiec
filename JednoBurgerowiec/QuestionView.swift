//
//  QuestionView.swift
//  JednoBurgerowiec
//
//  Created by Jan Klausa on 05.07.20.
//

import SwiftUI

struct QuestionView: View {

    let question: Question
    let shuffledAnswers: [String]
    // We can't shuffle the answers on-demand inside `body`, since then
    // every time the view gets re-rendered it'll have a different ordering, which
    // makes it impossible for us to mark answers as correct.

    let answerCallback: (Bool) -> Void

    @State private var answered: Bool = false
    @State private var pickedAnswerShuffledIndex: Int? = nil

    internal init(question: Question, answerCallback: @escaping (Bool) -> Void) {
        self.question = question
        self.answerCallback = answerCallback

        self.shuffledAnswers = question.answers.shuffled()
    }

    func isCorrect(answer: String, for question: Question) -> Bool {
        question.answers.firstIndex(of: answer) == question.correctAnswerIndex
    }

    func convertIndexToString(index: Int) -> String {
        // Is this a horrible hack? yes.
        // does it solve the problem we're having here in a simple way? also yes
        switch index {
        case 0:
            return "A"
        case 1:
            return "B"
        case 2:
            return "C"
        case 3:
            return "D"
        default:
            return "wat"
        }
    }

    var body: some View {
        VStack {

            Spacer()
                .frame(height: 20)

            Text(question.text)
                .padding()
                .minimumScaleFactor(0.6)
                .font(Font.title.bold())
                .foregroundColor(.white)


            Spacer()

            ForEach(Array(shuffledAnswers.enumerated()),
                    id: \.element) { index, answer in

                AnswerButton(answer: answer,
                             circleText: convertIndexToString(index: index),
                             state: answerButtonState(for: answer)) {
                                handleAnswerTap(answer: answer)
                }
            }

            Spacer()
                .frame(height: 20)
        }
        .frame(minWidth: 0,
               maxWidth: .infinity,
               minHeight: 0,
               maxHeight: .infinity)
        .background(Color.black)
        .edgesIgnoringSafeArea(.all)
        .cornerRadius(20)
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
    }

    private func answerButtonState(for answer: String) -> AnswerButton.State {
        guard answered, let answeredIndex = pickedAnswerShuffledIndex else {
            return .normal
        }

        if isCorrect(answer: answer, for: question) {
            return .correct
        }

        if shuffledAnswers[answeredIndex] == answer {
            return .pickedAndWrong
        }

        return .normal
    }

    private func handleAnswerTap(answer: String) {
        answered = true
        pickedAnswerShuffledIndex = shuffledAnswers.firstIndex(of: answer)!

        answerCallback(isCorrect(answer: answer, for: question))
    }


}

struct AnswerButton: View {

    enum State {
        case normal

        case pickedAndWrong
        // We don't need to differentiate between "correct" and "picked, and correct" states,
        // since they're visually indistinguishable, hence why this case is named so weirdly
        // as to not to be ambiguous what `picked` means

        case correct
    }

    let answer: String
    let circleText: String
    let state: State

    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack() {
                Spacer()
                    .frame(width: 5)

                CircleLabel(text: circleContent)

                Spacer()

                Text(answer)
                    .lineLimit(4)
                    .multilineTextAlignment(.center)
                    .minimumScaleFactor(0.4)
                    .font(Font.title2.bold())
                    .foregroundColor(.black)
                    .padding()

                Spacer()
                    .frame(width: 5)

            }
            .frame(maxWidth: .infinity)
            .frame(alignment: .leading)
            .background(Capsule()
                            .foregroundColor(capsuleColor))
            .padding()
            .padding(.vertical, -12)

        }
    }

    private var circleContent: String {
        switch state {
        case .normal:
            return circleText
        case .pickedAndWrong:
            return "❌"
        case .correct:
            return "✅"
        }
    }

    private var capsuleColor: Color {
        switch state {
        case .normal:
            return .white
        case .pickedAndWrong:
            return .red
        case .correct:
            return .green
        }
    }
}

struct CircleLabel: View {

    let text: String

    var body: some View {
        Text(text)
            .font(Font.headline.bold())
            .foregroundColor(.yellow)
            .padding()
            .background(Circle()
                            .foregroundColor(.black))
    }

}

struct QuestionView_Previews: PreviewProvider {
    static var previews: some View {
        let question = Question.allQuestions().randomElement()!

        return QuestionView(question: question) { correct in
            dump("correct")
            return
        }
    }
}
