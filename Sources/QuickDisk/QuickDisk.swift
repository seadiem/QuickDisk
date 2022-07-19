import Files
import Foundation


/// Quick saving and reading of the model from the Documents folder
public struct QuickSaveToDocuments<Model: Codable> {
    
    @StoreFile var file: File
    
    public init(fileName: String) {
        StoreFile.filename = fileName
    }
    
    public func save(model: Model) throws {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let data = try encoder.encode(model)
        try file.write(data)
    }
    public func load() throws -> Model {
        let decoder = JSONDecoder()
        let data = try file.read()
        let model = try decoder.decode(Model.self, from: data)
        return model
    }
    public func hardReset() throws {
        try file.delete()
    }
}


@propertyWrapper
struct StoreFile {
    
    @DocumentSubfolder(folderName: "QuickSave") var folder: Folder
    
    static var filename: String = "TempFile"
    
    var wrappedValue: File {
        get {
            do {
                let file = try folder.file(named: StoreFile.filename)
                return file
            } catch {
                do {
                    let file = try folder.createFile(named: StoreFile.filename)
                    return file
                } catch {
                    fatalError("QuickSaveToDocuments: could not create file")
                }
            }
        }
    }
}

/// A subfolder within Documents Folder
///
///        @DocumentSubfolder(folderName: "QuickSave") var folder: Folder
///
@propertyWrapper
public struct DocumentSubfolder {
    let foldername: String
    public init(folderName: String) {
        self.foldername = folderName
    }
    public var wrappedValue: Folder {
        get {
            if let folder = try? Folder.documents?.subfolder(named: foldername) {
                return folder
            } else {
                if let folder = try? Folder.documents?.createSubfolder(named: foldername) {
                    return folder
                } else {
                    fatalError("Experiments: could not create subfolder")
                }
            }
        }
    }
}
