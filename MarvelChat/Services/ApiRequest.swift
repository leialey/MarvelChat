//
//  ApiRequest.swift
//  MarvelChat
//
//  Created by Leialey on 28.12.2019.
//  Copyright © 2019 Ekaterina Rodionova. All rights reserved.
//

import Foundation
import Alamofire

struct ApiRequest {
    private let baseURL = "https://gateway.marvel.com:443/v1/public/characters"
    private let limit = 30
    private var offset: Int = 0
    private var apiKeys = [String: String]()
    private let ts = "\(Date().timeIntervalSince1970)"
    private var hash: String {
        return (ts + (apiKeys["privateKey"] ?? "") + (apiKeys["publicKey"] ?? "")).md5Value
    }
    private var params: Parameters?
    
    init(offset: Int) {
        guard let path = Bundle.main.path(forResource: "apiKeys", ofType: "plist") else { fatalError("apiKeys not found")}
        guard let keys = NSDictionary(contentsOfFile: path) as? [String : String] else { fatalError("apiKeys in wrong format")}
        apiKeys = keys
        self.offset = offset
        params = [
            "limit": limit,
            "offset": offset,
            "ts": ts,
            "apikey": apiKeys["publicKey"] ?? "",
            "hash": hash
        ]
    }
    
    func getDataRequest() -> DataRequest {
        return Alamofire.request(self.baseURL, method: .get, parameters: self.params)
    }
    
    func allDataFetched(for total: Int) -> Bool {
        return (self.offset >= total) ? true : false
    }
}


struct APIImage {
    private let fileExtension: String
    private var path: String
    var secureURL: URL?
    private let imageFormat = "standard_medium"
    
    init(path: String, fileExtension: String) {
        self.path = path
        self.fileExtension = fileExtension
        self.secureURL = URL(string: securePath(path: &self.path) + "/\(imageFormat)." + fileExtension)
    }
    
    private func securePath (path: inout String) -> String {
        if path.hasPrefix("http://") {
            path = path.replacingOccurrences(of: "http://", with: "https://")
        }
            return path
        }
}
