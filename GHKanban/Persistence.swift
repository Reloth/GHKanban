//
//  Persistence.swift
//  GHKanban
//
//  Created by Diego on 30/10/21.
//

import CoreData

/// Manages the retrieval, deletion and storage of the Repositories locally
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

    init() {
        container = NSPersistentContainer(name: "GHKanban")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
}
