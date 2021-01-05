import Foundation

struct BudgetItem: Codable, Equatable {
    var name: String = ""
    var cost: Double
    var notes: String
    var category: String
    var dateAndTime: Date

//    init(name: String, cost: Int, category: String, notes: String) {
//        self.name = name
//        self.cost = cost
//        self.category = category
//        self.notes = notes
//    }
    
    static func loadSampleData() -> [BudgetItem]{
        let budgetItems = [BudgetItem(cost: 0, notes: "", category: "Food", dateAndTime: Date())]
        return budgetItems
}

    
    static func getArchiveURL() -> URL {
        let plistName = "budgetItems"
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentsDirectory.appendingPathComponent(plistName).appendingPathExtension("plist")
    }

    static func saveToFile(budgetItems:[BudgetItem]) {
        let archiveURL = getArchiveURL()
        let propertyListEncoder = PropertyListEncoder()
        let encodedEvents = try? propertyListEncoder.encode(budgetItems)
        try? encodedEvents?.write(to: archiveURL, options: .noFileProtection)
    }
    
    static func loadFromFile() -> [BudgetItem]? {
        let archiveURL = getArchiveURL()
        let propertyListDecoder = PropertyListDecoder()
        guard let retrievedDayEventsData = try? Data(contentsOf: archiveURL) else { return nil }
        guard let decodedBudgetItems = try? propertyListDecoder.decode(Array<BudgetItem>.self, from: retrievedDayEventsData) else { return nil }
        return decodedBudgetItems
    }
}
