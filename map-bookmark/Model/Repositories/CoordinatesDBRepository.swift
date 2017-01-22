//
//  CoordinatesDBRepository.swift
//  map-bookmark
//
//  Created by Admin on 08.01.17.
//  Copyright © 2017 rizer. All rights reserved.
//

import UIKit
import PromiseKit

class CoordinatesDBRepository: CoordinatesDBRepositoryType {
    
    var rmManager: RealmManagerType!
    
    init(realmManager: RealmManagerType) {
        rmManager = realmManager
    }
    
    func removeCoordinate(coord: Coordinate) -> Promise<Coordinate> {
        return rmManager.removeCoordinate(coord)
    }
    
    func updateCoordinate(coord: Coordinate) -> Promise<Coordinate> {
        return rmManager.updateCoordinate(coord)
    }
    
    func loadCoordinates() -> Promise<[Coordinate]> {
        return rmManager.loadCoordinates()
    }
    
    func saveCoordinate(coord: Coordinate) -> Promise<Coordinate> {
        return rmManager.addCoordinate(coord)
    }
}
