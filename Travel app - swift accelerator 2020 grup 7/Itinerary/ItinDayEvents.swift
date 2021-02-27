import Foundation
struct DayEvent: Codable, Equatable{

    
    var destination: String
    var timeStart: String
    var timeEnd: String
    var date: String
    var notes: String
    
    
    static func loadSampleData() -> Dictionary<String, Array<DayEvent>>{
        let dayEvents = ["":[DayEvent(destination: "", timeStart: "", timeEnd: "", date: "", notes: "")]]
        return dayEvents
}

    
    static func getArchiveURL() -> URL {
        let plistName = "dayEvents"
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentsDirectory.appendingPathComponent(plistName).appendingPathExtension("plist")
    }

    static func saveToFile(dayEvents:Dictionary<String, Array<DayEvent>>) {
        let archiveURL = getArchiveURL()
        let propertyListEncoder = PropertyListEncoder()
        let encodedEvents = try? propertyListEncoder.encode(dayEvents)
        try? encodedEvents?.write(to: archiveURL, options: .noFileProtection)
    }
    
    static func loadFromFile() -> Dictionary<String, Array<DayEvent>>? {
        let archiveURL = getArchiveURL()
        let propertyListDecoder = PropertyListDecoder()
        guard let retrievedDayEventsData = try? Data(contentsOf: archiveURL) else { return nil }
        guard let decodedDayEvents = try? propertyListDecoder.decode(Dictionary<String, Array<DayEvent>>.self, from: retrievedDayEventsData) else { return nil }
        return decodedDayEvents
    }
}
