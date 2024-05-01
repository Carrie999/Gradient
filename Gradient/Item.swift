//
//  Item.swift
//  Gradient
//
//  Created by  玉城 on 2024/5/1.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
