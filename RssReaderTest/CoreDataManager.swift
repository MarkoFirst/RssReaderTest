//
//  CoreDataManager.swift
//  RssReaderTest
//
//  Created by MF-Citrus on 02.02.2022.
//

import Foundation
import CoreData

class CoreDataManager: NSObject {
    var managedObjectContext: NSManagedObjectContext!
    typealias CompletionHandler = (Error?) -> ()
    static let shared = CoreDataManager()
    
    private override init() {
        guard let modelURL = Bundle.main.url(forResource: "RssReaderTest", withExtension: "momd") else { return }
        guard let objectModel = NSManagedObjectModel(contentsOf: modelURL) else { return }
        
        let storeCoordinator = NSPersistentStoreCoordinator(managedObjectModel: objectModel)
        managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = storeCoordinator
        
        guard let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last else { return }
        let storeURL = documentsURL.appendingPathComponent("RssReaderTest.sqlite")
        
        do {
            let options = [NSInferMappingModelAutomaticallyOption : true,
                           NSMigratePersistentStoresAutomaticallyOption : true]
            try storeCoordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL, options: options)
        } catch {
            print("CoreData init error")
        }
        
        managedObjectContext.mergePolicy = NSMergePolicy(merge: .overwriteMergePolicyType)
        managedObjectContext.retainsRegisteredObjects = true
    }
    
    func getSourceList() -> [Source]? {
        let request = Source.fetchRequest() as NSFetchRequest
        if let sourceList = try? managedObjectContext.fetch(request) {
            return sourceList
        } else {
            return nil
        }
    }
    
    func saveSource(_ sourceData: [String: String]) -> Source? {
        guard let source = NSEntityDescription.insertNewObject(forEntityName: "Source", into: CoreDataManager.shared.managedObjectContext) as? Source else {
            return nil
        }
        
        source.id = sourceData["id"]
        source.name = sourceData["name"]
        return source
    }
}
