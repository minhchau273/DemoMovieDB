//
//  RealmObject.swift
//  DemoMovieDB
//
//  Created by EastAgile16 on 10/23/15.
//  Copyright © 2015 DaveVo. All rights reserved.
//

import RealmSwift

class RealmObject: Object {
    dynamic var id: Int = 0
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    func isNew() -> Bool {
        return id == 0
    }
    
    func setIdIfNeeded(realm: Realm) {
        if id == 0 {
            if let last = realm.objects(self.dynamicType).last {
                print("last id: \(last.id)")
                id = last.id + 1
            } else {
                print("Fisrt record. Setting id = 1")
                id = 1
            }
            
        }
    }
    
    func save() {
        let realm = try! Realm()
        setIdIfNeeded(realm)
        
        try! realm.write {
            realm.add(self, update: true)
        }
        print("Save \(self.dynamicType) id = \(id)")
    }
    
    func delete() {
        let realm = try! Realm()
        try! realm.write {
            realm.delete(self)
        }
    }
}
