//
//  Trip.swift
//  Travel app - swift accelerator 2020 grup 7
//
//  Created by Yu Youyou on 11/12/20.
//

import Foundation


class Trip{
    static func == (lhs: Trip, rhs: Trip) -> Bool {
        return true
    }
    
    
    var destination: String
    var startDate: Date
    var endDate: Date
    var itinerary: Dictionary<String, Array<DayEvent>>
    var budget: Dictionary<String, Array<BudgetItem>>
    var packingList: Array<packingItem>
    
    
    init(destination: String, startDate: Date, endDate: Date, itinerary: Dictionary<String, Array<DayEvent>>, budget: Dictionary<String, Array<BudgetItem>>, packingList: Array<packingItem> ){
        
        self.destination = destination
        self.startDate = startDate
        self.endDate = endDate
        self.itinerary = itinerary
        self.budget = budget
        self.packingList = packingList
    }
    
}
