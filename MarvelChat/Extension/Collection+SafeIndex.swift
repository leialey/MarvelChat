//
//  Collection+SafeIndex.swift
//  MarvelChat
//
//  Created by Leialey on 28.12.2019.
//  Copyright © 2019 Ekaterina Rodionova. All rights reserved.
//

import Foundation

public extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
