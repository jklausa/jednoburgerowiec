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

    var body: some View {
        VStack {
            Spacer()
                .frame(height: 20)
            Text(question.text)
                .font(.title)
                .lineLimit(10)
                .foregroundColor(.white)

            Spacer()
            ForEach(question.answers.shuffled(), id: \.self) { answer in
                Button(action: {
                    self.answerCallback(self.isCorrect(answer: answer, for: self.question))
                }) {
                    Text(answer)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .overlay(
                            RoundedRectangle(cornerRadius: 15, style: .continuous)
                                .stroke(Color.purple, lineWidth: 5))
                        .padding(.horizontal, 20)
                        .padding(.vertical, 5)
                }

            }
            Spacer()
                .frame(height: 20)
        }
        .frame(minWidth: 0,
               maxWidth: .infinity,
               minHeight: 0,
               maxHeight: .infinity)
        .background(Color.green)
        .edgesIgnoringSafeArea(.all)
        .cornerRadius(20)
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
        .shadow(radius: 4)
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
