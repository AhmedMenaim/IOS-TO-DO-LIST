//
//  TodoItem.swift
//  TodoList
//
//  Created by Omara on 20.10.18.
//  Copyright © 2018 Mahmoud Omara. All rights reserved.
//

import Foundation
import RealmSwift

class TodoItem: Object {
    
    
    @objc dynamic var title: String = ""
    @objc dynamic var ItemDescription: String?
    
    
    convenience init(title:String) {
        self.init()
        self.title = title
        
    }
    convenience init (title: String, description: String) {
        self.init()
        self.title = title
        self.ItemDescription = description
    }
    
}
