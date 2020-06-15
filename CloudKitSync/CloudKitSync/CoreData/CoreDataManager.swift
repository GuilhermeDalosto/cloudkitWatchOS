//
//  CoreDataManager.swift
//  CloudKitSync
//
//  Created by Guilherme Martins Dalosto de Oliveira on 10/06/20.
//  Copyright © 2020 Guilherme Martins Dalosto de Oliveira. All rights reserved.


import Foundation
import CoreData

final class CoreDataManager {
    
    static let shared = CoreDataManager()
        
    private init() {
        self.persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    public var persistentContainer: NSPersistentCloudKitContainer = {
        let container = NSPersistentCloudKitContainer(name: "CloudKitSync")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    public func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    public func insert(entityName: String,entityData: CharacterDef){
        let context = persistentContainer.viewContext
        guard let entityDescription = NSEntityDescription.entity(forEntityName: entityName, in: context) else { return }
        
        let entityObject = NSManagedObject(entity: entityDescription, insertInto: context) as! Character
        
        entityObject.name = entityData.name
        entityObject.age = entityData.age
        entityObject.race = entityData.race
        
        saveContext()
    }
    
    public func fetchAll<T: NSManagedObject>(_ objectType: T.Type) -> [T] {
        let entityName = String(describing: objectType)
                
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
         
        do {
            let fetchedObjects = try persistentContainer.viewContext.fetch(fetchRequest) as? [T]
            return fetchedObjects ?? [T]()
            
        } catch {
            print(error)
            return [T]()
        }
    }
    
    
    public func fetch<T: NSManagedObject>(_ objectType: T.Type, key: String,value: String, fetchLimit: Int?) -> [T] {
                
        let entityName = String(describing: objectType)
                
        let predicate = NSPredicate(format: "\(key) == %@", value)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        
        fetchRequest.predicate = predicate
        
        if let fetchLimit = fetchLimit { fetchRequest.fetchLimit = fetchLimit }
        
        do {
            let fetchedObjects = try persistentContainer.viewContext.fetch(fetchRequest) as? [T]
            return fetchedObjects ?? [T]()
            
        } catch {
            print(error)
            return [T]()
        }
    }
    
    public func delete(_ object: NSManagedObject) {
        persistentContainer.viewContext.delete(object)
        saveContext()
    }
    
}
