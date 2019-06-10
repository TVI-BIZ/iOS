//
//  StorageManager.swift
//  BestPlaces
//
//  Created by Vlad Tagunkov on 10/06/2019.
//  Copyright © 2019 TVI Software. All rights reserved.
//

import RealmSwift

let realm = try! Realm()

class StorageManager {
    
    static func saveObject( _ place: Place) {
        
        try! realm.write {
            realm.add(place)
        }
        
    }
    
}

