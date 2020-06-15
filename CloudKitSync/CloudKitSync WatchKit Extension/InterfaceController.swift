//
//  InterfaceController.swift
//  CloudKitSync WatchKit Extension
//
//  Created by Guilherme Martins Dalosto de Oliveira on 10/06/20.
//  Copyright © 2020 Guilherme Martins Dalosto de Oliveira. All rights reserved.
//

import WatchKit
import Foundation
import CoreData


class InterfaceController: WKInterfaceController {
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        let manager = CoreDataManager.shared
        let fetchResult = manager.fetch(Character.self, key: "name", value: "Guilherme", fetchLimit: 10)
        let fetchResultAll = manager.fetchAll(Character.self)
        
        // manager.insert(entityName: "Character", entityData: CharacterDef(name: "Guilherme", age: 10, race: "Orc"))
       for i in fetchResultAll{
            print(i.name)
        }
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
}
