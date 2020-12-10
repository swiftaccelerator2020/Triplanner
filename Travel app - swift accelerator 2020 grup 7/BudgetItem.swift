//
//  BudgetItem.swift
//  Travel app - swift accelerator 2020 grup 7
//
//  Created by Yu Youyou on 10/12/20.
//

import Foundation

class BudgetItem {
    var name: String = ""
    var cost: Int
    var notes: String
    var category: String

    init(name: String, cost: Int, category: String, notes: String) {
        self.name = name
        self.cost = cost
        self.category = category
        self.notes = notes
    }
}
