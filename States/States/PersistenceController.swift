//
//  PersistenceController.swift
//  States
//
//  Created by Nikhil Krishnaswamy on 6/7/23.
//

import Foundation
import CoreData

class PersistenceController {
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    
    private init() {
        container = NSPersistentContainer(name: "YourDataModelName") // Replace with your data model name
        
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Failed to initialize Core Data stack: \(error)")
            }
        }
    }
    
    func save() {
        if container.viewContext.hasChanges {
            do {
                try container.viewContext.save()
            } catch {
                fatalError("Failed to save changes to Core Data: \(error)")
            }
        }
    }
    
    static var preview: PersistenceController = {
        let container = NSPersistentContainer(name: "States") // Replace with your data model name
        container.persistentStoreDescriptions[0].url = URL(fileURLWithPath: "/dev/null")
        
        let result = PersistenceController(container: container)
        
        let viewContext = result.container.viewContext
        // Add some sample data for preview
        // viewContext.perform { ... }
        
        return result
    }()
    
    init(container: NSPersistentContainer) {
        self.container = container
    }
}
