//
//  AnswersBlock.swift
//  JednoBurgerowiec
//
//  Created by Jan Klausa on 15.07.20.
//

import SwiftUI
struct AnswersBlock: View {

    let questionState: QuestionState
    let answerCallback: (Int) -> Void

    var body: some View {
        VStack {
            ForEach(Array(questionState.answers.enumerated()), id: \.element) { index, answer in
                AnswerButton(answer: answer,
                             circleText: convertIndexToString(index: index),
                             state: answerButtonState(index: index)) {
                    answerCallback(index)
                }
            }
        }
    }

    private func convertIndexToString(index: Int) -> String {
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

    private func answerButtonState(index: Int) -> AnswerButton.State {
        guard questionState.answered else {
            return .normal
        }

        if index == questionState.correctAnswerIndex {
            return .correct
        } else if index == questionState.pickedIndex {
            return .pickedAndWrong
        } else {
            return .normal
        }
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

struct AnswersBlock_Previews: PreviewProvider {

    static var randomQuestion: Question {
        Question.allQuestions().randomElement()!
    }

    static var randomState: QuestionState {
        QuestionState(question: randomQuestion)
    }

    static var correctState: QuestionState {
        var state = randomState

        state.answer(index: state.correctAnswerIndex)

        return state
    }

    static var incorrectState: QuestionState {
        var state = randomState

        let correctIndex = state.correctAnswerIndex
        let wrongIndex: Int

        if correctIndex == state.answers.count - 1 {
            wrongIndex = correctIndex - 1
        } else {
            wrongIndex = correctIndex + 1
        }

        state.answer(index: wrongIndex)

        return state
    }

    static var previews: some View {
        Group {
            AnswersBlock(questionState: randomState, answerCallback: { _ in return })
            AnswersBlock(questionState: correctState, answerCallback: {_  in return })
            AnswersBlock(questionState: incorrectState, answerCallback: {_  in return })
        }.background(Color.gray)


    }
}

