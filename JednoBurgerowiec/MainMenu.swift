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
                .font(.largeTitle)
                .shadow(radius: 2)
                .foregroundColor(.white)
                .padding()
            Text("or an app to help you prepare for Einbürgerungstest")
                .font(.subheadline)
                .foregroundColor(.white)
            Spacer()
            Button("Just fuck me up") {
                dump("fuck me up")
                return
            }
            .padding()
            .padding(.horizontal, 30)
            .background(Color.white)
            .cornerRadius(100)
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
        .background(Color(Constants.backgroundColor))
        .edgesIgnoringSafeArea(.all)
    }

    private enum Constants {
        static let backgroundColor = UIColor(displayP3Red: 1,

                                             green: 0,
                                             blue: 0,
                                             alpha: 1)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenu(questions: Question.allQuestions())
    }
}
