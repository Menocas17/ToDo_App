//
//  To_do_AppApp.swift
//  To_do_App
//
//  Created by Rodolfo Menocal on 09/8/25.
//

import SwiftUI
import SwiftData

@main
struct To_do_AppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        
        .modelContainer(for: ToDo.self)
    }
}

// this model decorator helps us to data modeling and persistence

@Model class ToDo {
    var title: String
    var isCompleted: Bool
    
    init(title: String, isCompleted: Bool = false) {
        self.title = title
        self.isCompleted = isCompleted
    }
}
 
// This is helpful to comapre the data in the future
extension Bool: @retroactive Comparable {
    public static func <(lhs: Self, rhs: Self) -> Bool {
        !lhs && rhs
    }
}
