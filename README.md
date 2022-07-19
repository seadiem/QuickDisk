# QuickDisk

Sometimes you need to quickly save something and read it from disk. This package provides the ability to quickly do this without thinking, all that is required from the user is to specify a file name and provide a Codable model

        let bee = Bee(name: "Anna")
        let filename = "BeeFile"
        try? QuickSaveToDocuments(fileName: filename).save(model: bee)
        let restoreBee = try? QuickSaveToDocuments<Bee>(fileName: filename).load()
        assert(bee == restoreBee!)
 
