//
//  PackingItem.swift
//  Travel app - swift accelerator 2020 grup 7
//
//  Created by rochelletxy on 28/11/20.
//

import Foundation

class packingItem {
    
    var name: String
    var checked = false
    var note: String
    
    init(name: String, note: String) {
        self.name = name
        self.note = note
    }
}
 
