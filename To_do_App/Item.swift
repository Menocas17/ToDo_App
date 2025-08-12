//
//  Item.swift
//  To_do_App
//
//  Created by Rodolfo Menocal on 11/8/25.
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
