//
//  PackingItem.swift
//  Travel app - swift accelerator 2020 grup 7
//
//  Created by rochelletxy on 28/11/20.
//

import Foundation

struct PackingItem: Codable {
    
    var name: String
    var checked = false
    var note: String
    
//    init(name: String, note: String) {
//        self.name = name
//        self.note = note
//    }
    
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
 
