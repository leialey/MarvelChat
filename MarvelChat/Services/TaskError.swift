//
//  TaskError.swift
//  MarvelChat
//
//  Created by Leialey on 28.12.2019.
//  Copyright © 2019 Ekaterina Rodionova. All rights reserved.
//

import Foundation

public enum TaskError: Error {
    case notConnectedToInternet
    case errorAPI
    case errorRealm
    
    var errorDescription: String {
        switch self {
        case .notConnectedToInternet: return "Ошибка соединения"
        case .errorAPI: return "Ошибка запроса данных"
        case .errorRealm: return "Ошибка сохраненения сообщения"
        }
    }
}
