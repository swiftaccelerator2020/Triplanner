//
//  ItinDayEvents.swift
//  Travel app - swift accelerator 2020 grup 7
//
//  Created by Yu Youyou on 29/11/20.
//

import Foundation
struct DayEvent: Codable, Equatable{
//    static func == (lhs: DayEvent, rhs: DayEvent) -> Bool {
//        return true
//    }
//MARK: That is so weird, class gives me problems
    
    var destination: String
    var timeStart: String
    var timeEnd: String
    var date: String
    var notes: String
    
//    init(destination: String, timeStart: String, timeEnd: String, date: String, notes: String) {
//        self.destination = destination
//        self.date = date
//        self.timeStart = timeStart
//        self.timeEnd = timeEnd
//        self.date = date
//        self.notes = notes
//    }
    static func loadSampleData() -> [DayEvent]{
        let dayEvents = [DayEvent(destination: "", timeStart: "", timeEnd: "", date: "", notes: "")]
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
