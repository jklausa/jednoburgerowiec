//
//  JednoBurgerowiecApp.swift
//  JednoBurgerowiec
//
//  Created by Jan Klausa on 03.07.20.
//

import SwiftUI

@main
struct JednoBurgerowiecApp: App {

    var body: some Scene {
        WindowGroup {
            MainMenu(questions: Question.allQuestions())
        }
    }

}

struct Question: Codable, Identifiable {
    let text: String

    let answers: [String]
    let correctAnswerIndex: Int

    var id: String {
        return text
    }

    enum CodingKeys: String, CodingKey {
        case text = "questionText"
        case answers
        case correctAnswerIndex = "correct_answer_index"
    }

    static func allQuestions() -> [Question] {
        let bundleFile = Bundle.main.url(forResource: "questions", withExtension: "json")

        let jsonDecoder = JSONDecoder()

        return try! jsonDecoder.decode([Question].self, from: try! .init(contentsOf: bundleFile!))
    }
}
