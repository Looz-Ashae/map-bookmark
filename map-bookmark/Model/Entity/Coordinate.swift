//
//  Coordinate.swift
//  map-bookmark
//
//  Created by Admin on 04.01.17.
//  Copyright © 2017 rizer. All rights reserved.
//

import Foundation

class Coordinate: NSObject {
    var name: String!
    var latitude: Double!
    var longitude: Double!
    var coordDescription: String!
    var id: Int!
    
    override init() {
        super.init()
    }
    
    convenience init(dbCoordinate: RCoordinate) {
        self.init()
        self.name = dbCoordinate.name
        self.latitude = dbCoordinate.latitude
        self.longitude = dbCoordinate.longitude
        self.coordDescription = dbCoordinate.coordDescription
        self.id = dbCoordinate.id
    }
    
    convenience init(name: String, description: String) {
        self.init()
        self.name = name
        self.coordDescription = description
    }
}

extension Coordinate: Comparable {
    
}

func <(lhs: Coordinate, rhs: Coordinate) -> Bool  {
    return lhs.id < rhs.id
}


func <=(lhs: Coordinate, rhs: Coordinate) -> Bool {
    return lhs.id <= rhs.id
}

func >=(lhs: Coordinate, rhs: Coordinate) -> Bool {
    return lhs.id >= rhs.id
}

func >(lhs: Coordinate, rhs: Coordinate) -> Bool {
    return lhs.id > rhs.id
}

func ==(lhs: Coordinate, rhs: Coordinate) -> Bool {
    return lhs.id == rhs.id
}
