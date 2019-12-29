//
//  MessagesViewController.swift
//  MarvelChat
//
//  Created by Leialey on 27.12.2019.
//  Copyright © 2019 Ekaterina Rodionova. All rights reserved.
//

import UIKit

class MessagesViewController: UIViewController {
    var messagesViewModel: MessagesViewModel?
    private let tableCellID = "MessageCell"
    private let collectionCellID = "AnswerCell"
    
    @IBOutlet weak var messagesTable: UITableView!
    @IBOutlet weak var answersCollection: UICollectionView!
    @IBOutlet weak var collectionLayout: UICollectionViewFlowLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = messagesViewModel?.character.name
        messagesTable.register(UINib(nibName: "MessageTableViewCell", bundle: nil), forCellReuseIdentifier: tableCellID)
        answersCollection.register(UINib(nibName: "AnswerCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: collectionCellID)
        
        messagesViewModel?.onSuccess = { [weak self] deletions, insertions, modifications in
            self?.messagesTable.beginUpdates()
            self?.messagesTable.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0) }), with: .fade)
            self?.messagesTable.endUpdates()
            self?.scrollToBottom()
        }
        
        messagesViewModel?.onError = { [weak self] error in
            self?.navigationItem.title = error.errorDescription
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                self?.navigationItem.title = self?.messagesViewModel?.character.name
            }
        }        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        scrollToBottom()
    }
    
    private func scrollToBottom() {
        let lastRow = (messagesViewModel?.messages?.count ?? 1) - 1
        let indexPath = IndexPath(row: lastRow, section: 0)
        messagesTable.scrollToRow(at: indexPath, at: .bottom, animated: true)
    }
}

// MARK: - Table view data source
extension MessagesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (messagesViewModel?.messages?.count ?? 0)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableCellID, for: indexPath) as! MessageTableViewCell
        cell.setup(character: messagesViewModel?.character, messageData: messagesViewModel?.messages?[safe: indexPath.row])
        return cell
    }
}

extension MessagesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messagesViewModel?.messagesData.numberOfAnswers ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionCellID, for: indexPath) as! AnswerCollectionViewCell
        cell.answerData = messagesViewModel?.messagesData.getAnswer(index: indexPath.row)
        cell.sendAnswer = { [weak self] message in
            self?.messagesViewModel?.sendMessage(message)
        }
        return cell
    }
}
