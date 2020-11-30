//
//  ItinDayEvents.swift
//  Travel app - swift accelerator 2020 grup 7
//
//  Created by Yu Youyou on 29/11/20.
//

import Foundation
struct DayEvent: Codable {
    
    var destination: String
    var timeStart: String
    var timeEnd: String
    var date: String
    var notes: String


static func loadSampleData() -> [DayEvent]{
    let dayEvents = [
        DayEvent(destination: "Bali", timeStart: "16:00", timeEnd: "17:00", date: "Jan 5, 2020", notes:"Bali")]
    
    return dayEvents
}
    
    static func getArchiveURL() -> URL {
        let plistName = "dayEvents"
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentsDirectory.appendingPathComponent(plistName).appendingPathExtension("plist")
    }

    static func saveToFile(dayEvents:[DayEvent]) {
        let archiveURL = getArchiveURL()
        let propertyListEncoder = PropertyListEncoder()
        let encodedEvents = try? propertyListEncoder.encode(dayEvents)
        try? encodedEvents?.write(to: archiveURL, options: .noFileProtection)
    }
    
    static func loadFromFile() -> [DayEvent]? {
        let archiveURL = getArchiveURL()
        let propertyListDecoder = PropertyListDecoder()
        guard let retrievedDayEventsData = try? Data(contentsOf: archiveURL) else { return nil }
        guard let decodedDayEvents = try? propertyListDecoder.decode(Array<DayEvent>.self, from: retrievedDayEventsData) else { return nil }
        return decodedDayEvents
    }
}
