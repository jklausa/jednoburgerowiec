//
//  QuestionView.swift
//  JednoBurgerowiec
//
//  Created by Jan Klausa on 05.07.20.
//

import SwiftUI

struct QuestionView: View {

    let question: Question
    let answerCallback: (Bool) -> Void

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

            ForEach(Array(question.answers.shuffled().enumerated()), id: \.element) { index, answer in
                AnswerButton(answer: answer, circleText: convertIndexToString(index: index)) { self.answerCallback(self.isCorrect(answer: answer, for: self.question))
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
}

struct AnswerButton: View {

    let answer: String
    let circleText: String

    let action: () -> Void

    var body: some View {
        HStack() {
            Spacer()
                .frame(width: 5)

            CircleLabel(text: circleText)

            Spacer()

            Text(answer)
                .multilineTextAlignment(.center)
                .font(Font.title2.bold())
                .foregroundColor(.black)
                .padding()

            Spacer()
                .frame(width: 5)

        }
        .frame(maxWidth: .infinity)
        .frame(alignment: .leading)
        .background(Capsule()
                        .foregroundColor(.white))
        .padding()
        .padding(.vertical, -12)
    }

}

struct CircleLabel: View {

    let text: String

    var body: some View {
        Text(text)
            .font(Font.headline.bold())
            .minimumScaleFactor(0.6)
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
