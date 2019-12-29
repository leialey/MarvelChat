//
//  CharactersViewModel.swift
//  MarvelChat
//
//  Created by Leialey on 27.12.2019.
//  Copyright © 2019 Ekaterina Rodionova. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class CharactersViewModel {
    var characters = [Character]()
    var totalCharacters = 1
    var requestedFetchIndex: Int = 0
    var onSuccess: (() -> ())?
    var onError: ((TaskError) -> ())?
    private var isFetchInProgress = false
    private let manager = NetworkReachabilityManager(host: "www.apple.com")
    
    init() {
        manager?.listener = { status in
            if status == .notReachable {
                self.onError?(TaskError.notConnectedToInternet)
            } else {
                //Once connection restored, load all requested characters
                self.fetchCharacters(from: self.requestedFetchIndex)
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            self.manager?.startListening()
        }
    }
    
    deinit {
        manager?.stopListening()
    }
    
    
    func fetchCharacters(from index: Int) {
        //No parallel fetching or fetching same characters
        if self.isFetchInProgress || index < characters.count {
            return
        }
        let apiRequest = ApiRequest(offset: self.characters.count)
        //We already fetched all characters
        if apiRequest.allDataFetched(for: self.totalCharacters) {
            self.onSuccess?()
            manager?.stopListening()
            return
        }
        self.requestedFetchIndex = index
        //Start fetching
        self.isFetchInProgress = true
        apiRequest.getDataRequest().responseJSON { response in
            if response.result.isSuccess {
                self.parseJSON(jsonString: response.result.value)
            } else {
                self.onError?(TaskError.errorAPI)
            }
            self.isFetchInProgress = false
        }
    }
    
    
    private func parseJSON(jsonString: Any?) {
        guard let jsonString = jsonString else { self.onError?(TaskError.errorAPI); return }
        let json = JSON(jsonString)
        self.totalCharacters = json["data"]["total"].intValue
        self.characters.append(contentsOf: json["data"]["results"].arrayValue.map{Character(id: $0["id"].intValue, name: $0["name"].stringValue, imageURL: APIImage(path: $0["thumbnail"]["path"].stringValue, fileExtension: $0["thumbnail"]["extension"].stringValue).secureURL)})
        self.onSuccess?()
    }
}
