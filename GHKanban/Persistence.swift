//
//  Persistence.swift
//  GHKanban
//
//  Created by Diego on 30/10/21.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    
    var viewContext: NSManagedObjectContext {
        return container.viewContext
    }
    
    func save() {
        do {
            try viewContext.save()
        }
        catch {
            viewContext.rollback()
        }
    }
    
    func getAllRepositories() -> [Repository] {
        let request: NSFetchRequest<Repository> = Repository.fetchRequest()
        do {
            return try viewContext.fetch(request)
        }
        catch {
            return [] 
        }
    }
    
    func deleteRepository(repository: Repository) {
        viewContext.delete(repository)
        self.save()
    }

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "GHKanban")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                Typical reasons for an error here include:
                * The parent directory does not exist, cannot be created, or disallows writing.
                * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                * The device is out of space.
                * The store could not be migrated to the current model version.
                Check the error message to determine what the actual problem was.
                */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
}
