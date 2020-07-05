//
//  ContentView.swift
//  JednoBurgerowiec
//
//  Created by Jan Klausa on 03.07.20.
//

import SwiftUI

struct MainMenu: View {

    let questions: [Question]

    var body: some View {
        VStack {
            Spacer()
            Text("JednoBurgerowiec")
                .font(Font.largeTitle.bold())
                .shadow(radius: 2)
                .foregroundColor(.white)
                .padding()
            Text("or an app to help you prepare for Einbürgerungstest")
                .font(.subheadline)
                .foregroundColor(.white)
            Spacer()
            NavigationLink(
                destination: QuestionView(question: questions.first!, answerCallback: { _ in
                    return
                }),
                label: {
                    Text("all shit")
                        .modifier(BigButtonViewModifier())
                })


            Text("Go through the entire body of test questions, randomized.")
                .padding()
            Button("Practice test") {
                dump("practice")
                return
            }
            .padding()
            .padding(.horizontal, 30)
            .background(Color.white)
            .cornerRadius(100)
            Text("Answer 33 questions, like on the real exam.")
                .padding()
        }
        .frame(minWidth: 0,
               maxWidth: .infinity,
               minHeight: 0,
               maxHeight: .infinity)
        .background(Color.black)
        .edgesIgnoringSafeArea(.all)
    }
}

private struct BigButtonViewModifier: ViewModifier {

    func body(content: Content) -> some View {
        content
            .padding()
            .padding(.horizontal, 30)
            .background(Color.white)
            .cornerRadius(100)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenu(questions: Question.allQuestions())
    }
}
