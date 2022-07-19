import Foundation
import QuickDisk
import Files

@main struct Runner {
    static func main() {
        TestQuickSave().test()
    }
}

struct Bee: Codable, Equatable {
    let name: String
}

struct TestQuickSave {
    
    @DocumentSubfolder(folderName: "QuickSave") var folder: Folder
    
    func test() {
        let bee = Bee(name: "Anna")
        let filename = "BeeFile"
        try? QuickSaveToDocuments(fileName: filename).save(model: bee)
        let restoreBee = try? QuickSaveToDocuments<Bee>(fileName: filename).load()
        assert(bee == restoreBee!)
        print("compleet")
    }
}



