import Foundation
struct PackingItem: Codable, Comparable{
    
    static func < (lhs: PackingItem, rhs: PackingItem) -> Bool {
        return true
    }
    
    
    var name: String
    var checked = false
    var note: String
    
    
    
    static func loadSampleData() -> [PackingItem]{
        let packingItems = [PackingItem(name: "", checked: false, note: "")]
        return packingItems
}

    
    static func getArchiveURL() -> URL {
        let plistName = "packingItems"
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentsDirectory.appendingPathComponent(plistName).appendingPathExtension("plist")
    }

    static func saveToFile(packingItems:[PackingItem]) {
        let archiveURL = getArchiveURL()
        let propertyListEncoder = PropertyListEncoder()
        let encodedEvents = try? propertyListEncoder.encode(packingItems)
        try? encodedEvents?.write(to: archiveURL, options: .noFileProtection)
    }
    
    static func loadFromFile() -> [PackingItem]? {
        let archiveURL = getArchiveURL()
        let propertyListDecoder = PropertyListDecoder()
        guard let retrievedDayEventsData = try? Data(contentsOf: archiveURL) else { return nil }
        guard let decodedPackingItems = try? propertyListDecoder.decode(Array<PackingItem>.self, from: retrievedDayEventsData) else { return nil }
        return decodedPackingItems
    }
}
 
