//
//  Trip.swift
//  Travel app - swift accelerator 2020 grup 7
//
//  Created by Yu Youyou on 11/12/20.
//
/*
import Foundation


struct Trip: Codable{
    
    /*static func == (lhs: Trip, rhs: Trip) -> Bool {
        return true
    }*/
    
    
    var destination: String
    var startDate: Date
    var endDate: Date
    var itinerary: Dictionary<String, Array<DayEvent>>
    var budget: Dictionary<String, Array<BudgetItem>>
    var packingList: Array<PackingItem>
    
    
//    init(destination: String, startDate: Date, endDate: Date, itinerary: Dictionary<String, Array<DayEvent>>, budget: Dictionary<String, Array<BudgetItem>>, packingList: Array<packingItem> ){
//
//        self.destination = destination
//        self.startDate = startDate
//        self.endDate = endDate
//        self.itinerary = itinerary
//        self.budget = budget
//        self.packingList = packingList
//    }
    
    static func loadSampleData() -> [Trip]{
        let trips = [Trip(destination: "", startDate: Date(), endDate: Date(), itinerary: [:], budget: [:], packingList: [])]
       return trips
        
    }
        
    static func getArchiveURL() -> URL {
        let plistName = "trips"
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentsDirectory.appendingPathComponent(plistName).appendingPathExtension("plist")
    }

    static func saveToFile(trips: [Trip]) {
        let archiveURL = getArchiveURL()
        let propertyListEncoder = PropertyListEncoder()
        let encodedFriends = try? propertyListEncoder.encode(trips)
        try? encodedFriends?.write(to: archiveURL, options: .noFileProtection)
    }

    static func loadFromFile() -> [Trip]? {
        let archiveURL = getArchiveURL()
        let propertyListDecoder = PropertyListDecoder()
        guard let retrievedFriendsData = try? Data(contentsOf: archiveURL) else { return nil }
        guard let decodedTrips = try? propertyListDecoder.decode(Array<Trip>.self, from: retrievedFriendsData) else { return nil }
        return decodedTrips
    }
    
}*/
import Foundation

struct Trip: Codable{
    
    var destination: String
    var startDate: Date
    var endDate: Date
    var itinerary: Dictionary<String, Array<DayEvent>>
    var budget: Dictionary<String, Array<BudgetItem>>
    var packingList: Array<PackingItem>
    
    static func loadSampleData() -> [Trip]{
        let trips = [Trip(destination: "", startDate: Date(), endDate: Date(), itinerary: [:], budget: [:], packingList: [])]
       return trips
        
    }
        
    static func getArchiveURL() -> URL {
        let plistName = "trips"
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentsDirectory.appendingPathComponent(plistName).appendingPathExtension("plist")
    }

    static func saveToFile(trips: [Trip]) {
        let archiveURL = getArchiveURL()
        let propertyListEncoder = PropertyListEncoder()
        //let encodedFriends = try? propertyListEncoder.encode(trips)
        let encodedTrips = try? propertyListEncoder.encode(trips)
        try? encodedTrips?.write(to: archiveURL, options: .noFileProtection)
    }

    static func loadFromFile() -> [Trip]? {
        let archiveURL = getArchiveURL()
        let propertyListDecoder = PropertyListDecoder()
        guard let retrievedTripsData = try? Data(contentsOf: archiveURL) else { return nil }
        guard let decodedTrips = try? propertyListDecoder.decode(Array<Trip>.self, from: retrievedTripsData) else { return nil }
        return decodedTrips
    }
    
}
