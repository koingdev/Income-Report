//
//  CoreDataCloudKitService.swift
//  Income Report
//
//  Created by KoingDev on 13/6/22.
//

import CoreData

struct CoreDataCloudKitService {
    
    static let shared = CoreDataCloudKitService()
    
    private init() { }

    private let container: NSPersistentCloudKitContainer = {
        let container = NSPersistentCloudKitContainer(name: "IncomeCoreDataModel")
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

    static func fetch(_ request: NSFetchRequest<Income>) -> [Income] {
        do {
            let result = try viewContext.fetch(request)
            return result
        } catch let error {
            debugPrint("Error: \(error)")
            return []
        }
    }

    @discardableResult
    static func save(rielIncome: Double, usdIncome: Double, date: Date) -> Bool {
        let income = Income(context: viewContext)
        income.id = UUID()
        income.rielIncome = rielIncome
        income.usdIncome = usdIncome
        income.date = date

        do {
            try viewContext.save()
            return true
        } catch {
            debugPrint("Error: \(error)")
            return false
        }
    }
    
    @discardableResult
    static func delete(income: Income) -> Bool {
        viewContext.delete(income)
        
        do {
            try viewContext.save()
            return true
        } catch {
            debugPrint("Error: \(error)")
            return false
        }
    }
}
