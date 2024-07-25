//
//  Persistence.swift
//  IllumiNote
//
//  Created by Iva Chho on 7/12/24.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController() // shared instance

    let container: NSPersistentContainer

    init(inMemory: Bool = false) { // can specify if you want to store data in memory (for testing) or on disk
        
        // initialize the NSPersistentContainer
        container = NSPersistentContainer(name: "IllumiNoteModel")
        
        // for in memory storage
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        
        // load the persistence store
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }

    // context - computed property used to interact with the core data stack to store, insert, etc
    var context: NSManagedObjectContext {
        return container.viewContext
    }
}
