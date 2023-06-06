import Foundation

class DataPersistence {
    
    private let fileManager = FileManager.default
    private let documentsDirectory: URL
    private let entriesURL: URL
    
    init(){
        self.documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        self.entriesURL = documentsDirectory.appendingPathComponent("entries").appendingPathExtension("json")
    }
    
    func saveEntries(entries: [DiaryModel]) throws {
        let encoder = JSONEncoder()
        let encodedEntries = try encoder.encode(entries)
        try encodedEntries.write(to: entriesURL)
    }
    
    func loadEntries() throws -> [DiaryModel] {
        guard fileManager.fileExists(atPath: entriesURL.path) else {
            return []
        }
        
        let decoder = JSONDecoder()
        let data = try Data(contentsOf: entriesURL)
        let decodedEntries = try decoder.decode([DiaryModel].self, from: data)
        return decodedEntries
    }
    
}
