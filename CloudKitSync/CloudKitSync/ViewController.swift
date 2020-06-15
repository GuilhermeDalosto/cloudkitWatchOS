//
//  ViewController.swift
//  CloudKitSync
//
//  Created by Guilherme Martins Dalosto de Oliveira on 10/06/20.
//  Copyright © 2020 Guilherme Martins Dalosto de Oliveira. All rights reserved.
//

import UIKit
import CoreData



class ViewController: UIViewController {

     override func viewDidLoad() {
          super.viewDidLoad()
          // Do any additional setup after loading the view.
        let manager = CoreDataManager.shared
        let fetchResult = manager.fetch(Character.self, key: "name", value: "Guilherme", fetchLimit: 10)
        let fetchResultAll = manager.fetchAll(Character.self)
          
         manager.insert(entityName: "Character", entityData: CharacterDef(name: "Gui", age: 10, race: "Orquee"))
        
        for i in fetchResultAll{
            print(i.name)
        }
          
          
      }

}

