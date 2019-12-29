//
//  MessagesData.swift
//  MarvelChat
//
//  Created by Leialey on 27.12.2019.
//  Copyright © 2019 Ekaterina Rodionova. All rights reserved.
//

import Foundation

struct Message {
    let text: String
}


struct MessagesData {
    var numberOfAnswers: Int
    private static let questionMessages = [
        "Есть задания на сегодня?",
        "Спасаем планету?",
        "Может, устроим выходной?",
        "А ты готов сражаться против Темной силы?"
    ]
    
    private static let answerMessages = [
        "Точно Нет!",
        "Конечно!",
        "Надо подумать...",
        "Слишком рано",
        "Уже поздно"
    ]
    
    init() {
        self.numberOfAnswers = MessagesData.answerMessages.count
    }
    
    func getRandomQuestion() -> Message {
        let total = MessagesData.questionMessages.count
        let index = Int.random(in: 0 ..< total)
        let question = MessagesData.questionMessages.map({Message(text: $0)})[index]
        return question
    }
    
    func getAnswer(index: Int) -> Message {
        let answer = MessagesData.answerMessages.map({Message(text: $0)})[index]
        return answer
    }
    
    
    
}

