//
//  MessagesViewModel.swift
//  MarvelChat
//
//  Created by Leialey on 27.12.2019.
//  Copyright © 2019 Ekaterina Rodionova. All rights reserved.
//

import Foundation
import RealmSwift

class MessagesViewModel {
    var messages: Results<ChatMessage>?
    let messagesData = MessagesData()
    private var notificationToken : NotificationToken?
    var onSuccess: (([Int], [Int], [Int]) -> ())?
    var onError: ((TaskError) -> ())?
    var realm = try! Realm()
    var character: Character
    
    init(character: Character) {
        messages = realm.objects(ChatMessage.self).filter("characterID == %@", character.id).sorted(byKeyPath: "date")
        self.character = character
        if messages?.count == 0 {
            reply(message: "Привет, я \(character.name)")
        }
        notificationToken = messages?.observe { [weak self] (changes: RealmCollectionChange) in
            switch changes {
            case .initial:
                return
            case .update(_, let deletions, let insertions, let modifications):
                self?.onSuccess?(deletions, insertions, modifications)
            case .error(let error):
                fatalError("\(error)")
            }
        }
    }
    
    func sendMessage(_ message: String) {
        let chatMessage =  ChatMessage(character: self.character, message: message, isUser: true)
        saveMessage(chatMessage)
        let question = messagesData.getRandomQuestion().text
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.reply(message: question)
        }
    }
    
    private func reply(message: String) {
        let chatMessage = ChatMessage(character: self.character, message: message, isUser: false)
        saveMessage(chatMessage)
    }
    
    private func saveMessage(_ chatMessage: ChatMessage) {
        do {
            try realm.write {
                realm.add(chatMessage)
            }
        } catch {
            onError?(TaskError.errorRealm)
            return
        }
    }
    
    deinit {
        notificationToken?.invalidate()
    }    
}
