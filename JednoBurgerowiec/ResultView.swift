//
//  ResultView.swift
//  JednoBurgerowiec
//
//  Created by Jan Klausa on 08.07.20.
//

import SwiftUI

struct ResultView: View {

    let score: Int
    let numberOfQuestions: Int

    var body: some View {
        VStack {
            Text("You answered \(String(score)) questions correctly.")
                .foregroundColor(.white)
                .font(.largeTitle)
                .bold()
                .multilineTextAlignment(.center)
            Text("(out of \(String(numberOfQuestions)) total)")
                .foregroundColor(.white)
                .font(.title)
                .bold()
                .multilineTextAlignment(.center)
                .padding()
            Text("That's \(correctAnswerPercentageLabel)%, which means:")
                .foregroundColor(.white)
                .font(.headline)
                .bold()
                .padding()
                .multilineTextAlignment(.center)

            if isPassingScore {
                Text("You passed! ✨✨👍")
                    .foregroundColor(.yellow)
                    .font(.largeTitle)
                    .bold()
                    .padding()

            } else {
                Text("Unfortunately, you failed 😅👎😅")
                    .foregroundColor(.red)
                    .font(.largeTitle)
                    .bold()
                    .padding()
            }
        }
        .frame(minWidth: 0,
               maxWidth: .infinity,
               minHeight: 0,
               maxHeight: .infinity)
        .background(Color.black)
        .edgesIgnoringSafeArea(.all)



    }

    var isPassingScore: Bool {
        (Double(score) / Double(numberOfQuestions)) > 0.5
    }

    var correctAnswerPercentageLabel: String {
        let fractionCorrect = Double(score) / Double(numberOfQuestions)
        let percentageCorrect = fractionCorrect * 100

        return String(Int(percentageCorrect.rounded()))
    }

}

struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ResultView(score: 20, numberOfQuestions: 33)
            ResultView(score: 1, numberOfQuestions: 30)
        }
    }
}
