//
//  CoreDataCloudKitService.swift
//  Income Report
//
//  Created by KoingDev on 13/6/22.
//

import CoreData

let containerName = "IncomeCoreDataModel"

struct PersistenceController {
    
    static let shared = PersistenceController()
    
    private init() { }

    private let container: NSPersistentCloudKitContainer = {
        let container = NSPersistentCloudKitContainer(name: containerName)
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                /*
                Typical reasons for an error here include:
                * The parent directory does not exist, cannot be created, or disallows writing.
                * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                * The device is out of space.
                * The store could not be migrated to the current model version.
                Check the error message to determine what the actual problem was.
                */
                debugPrint("Unresolved error \(error), \(error.userInfo)")
            }
        })

        return container
    }()
    
    static var viewContext: NSManagedObjectContext { shared.container.viewContext }

    @discardableResult
    static func save() -> Bool {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
                return true
            } catch {
                debugPrint("Error: \(error)")
            }
        }
        return false
    }
    
    @discardableResult
    static func delete(_ object: NSManagedObject) -> Bool {
        viewContext.delete(object)
        return save()
    }
    
    static func fetch<T>(_ request: NSFetchRequest<T>) -> [T] where T : NSFetchRequestResult {
        do {
            return try viewContext.fetch(request)
        } catch {
            debugPrint("Error: \(error)")
            return []
        }
    }
}
