//
//  CharactersTableViewController.swift
//  MarvelChat
//
//  Created by Leialey on 27.12.2019.
//  Copyright © 2019 Ekaterina Rodionova. All rights reserved.
//

import UIKit

class CharactersTableViewController: UITableViewController {
    private let cellID = "CharacterCell"
    private var characterVM = CharactersViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "CharacterTableViewCell", bundle: nil), forCellReuseIdentifier: cellID)
        
        characterVM.onError = { [weak self] error in
            self?.navigationItem.title = error.errorDescription
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                self?.navigationItem.title = "MARVEL UNIVERSE"
            }
        }
        
        characterVM.onSuccess = { [weak self] in
            self?.tableView.reloadData()
        }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return min(characterVM.characters.count + 1, characterVM.totalCharacters)
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! CharacterTableViewCell
        cell.characterData = characterVM.characters[safe: indexPath.row]
        if cell.characterData == nil  {
            characterVM.fetchCharacters(from: indexPath.row)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToChat", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let selectedIndex = tableView.indexPathForSelectedRow?.row {
            let character = characterVM.characters[selectedIndex]
            let chatVC = segue.destination as! MessagesViewController
            chatVC.messagesViewModel = MessagesViewModel(character: character)
        }
    }
    
}
