//
//  QuestionView.swift
//  JednoBurgerowiec
//
//  Created by Jan Klausa on 05.07.20.
//

import SwiftUI

struct QuestionView: View {

    @Binding var question: QuestionState
    let answerCallback: () -> Void

    var body: some View {
        VStack {

            Spacer()
                .frame(height: 20)

            Text(question.question)
                .padding()
                .minimumScaleFactor(0.6)
                .font(Font.title.bold())
                .foregroundColor(.white)


            Spacer()

            AnswersBlock(questionState: question) {
                question.answer(index: $0)
                answerCallback()
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


struct QuestionView_Previews: PreviewProvider {

    static var randomQuestion: Question {
        Question.allQuestions().randomElement()!
    }

    static var previews: some View {
        StatefulPreviewWrapper(QuestionState(question: randomQuestion)) {
            QuestionView(question: $0) { return }
        }
    }
}

struct StatefulPreviewWrapper<Value, Content: View>: View {
    @State var value: Value
    var content: (Binding<Value>) -> Content

    var body: some View {
        content($value)
    }

    init(_ value: Value, content: @escaping (Binding<Value>) -> Content) {
        self._value = State(wrappedValue: value)
        self.content = content
    }
}
