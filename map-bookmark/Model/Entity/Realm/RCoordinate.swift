//
//  RCoordinate.swift
//  map-bookmark
//
//  Created by Admin on 07.01.17.
//  Copyright © 2017 rizer. All rights reserved.
//

import Foundation
import RealmSwift

class RCoordinate: Object {
    
    dynamic var name: String = ""
    dynamic var latitude: Double = 0.0
    dynamic var longitude: Double = 0.0
    dynamic var coordDescription: String = ""
    dynamic var id: Int = 0
    
    func construct(coordinate: Coordinate) {
        if let name = coordinate.name {
            self.name = name
        }
        if let coordDescription = coordinate.coordDescription {
            self.coordDescription = coordDescription
        }
        if let id = coordinate.id {
            self.id = id
        }
        if let longitude = coordinate.longitude {
            self.longitude = longitude
        }
        if let latitude = coordinate.latitude {
            self.latitude = latitude
        }
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    func incrementID() -> Int {
        let realm = try! Realm()
        return (realm.objects(RCoordinate.self).max("id") as Int? ?? 0) + 1
    }
    
}
