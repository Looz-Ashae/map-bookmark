//
//  CoordinatesService.swift
//  map-bookmark
//
//  Created by Admin on 08.01.17.
//  Copyright © 2017 rizer. All rights reserved.
//

import Foundation
import PromiseKit

class CoordinatesService : CoordinatesServiceType {
    
    var dbManager: CoordinatesDBRepositoryType
    var geoLocationRepo: GeoLocationRepositoryType
    
    init(dbManager: CoordinatesDBRepositoryType, geoLocRepo: GeoLocationRepositoryType) {
        self.dbManager = dbManager
        self.geoLocationRepo = geoLocRepo
    }
    
    func loadCoordinates() -> Promise<[Coordinate]> {
        return dbManager.loadCoordinates()
    }
    
    func updateCoordinate(coord: Coordinate) -> Promise<Coordinate> {
        return dbManager.updateCoordinate(coord)
    }
    
    func deleteCoordinate(coord: Coordinate) -> Promise<Coordinate> {
        return dbManager.removeCoordinate(coord)
    }
    
    func saveCoordinate(coord: Coordinate) -> Promise<Coordinate> {
        return dbManager.saveCoordinate(coord)
    }
    
    func getCurrentCoordinate(coord: Coordinate) -> Promise<Coordinate> {
        return geoLocationRepo.getCurrentCoordinate(coord).then { (coordinate) -> Promise<Coordinate> in
            self.dbManager.saveCoordinate(coordinate)
        }
    }
    
    
}
