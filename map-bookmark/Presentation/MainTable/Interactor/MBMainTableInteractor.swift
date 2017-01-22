//
//  MBMainTableMBMainTableInteractor.swift
//  map-bookmark
//
//  Created by rizer on 03/01/2017.
//  Copyright © 2017 com.rizer. All rights reserved.
//

import PromiseKit

class MainTableInteractor: MainTableInteractorInput {

    weak var output: MainTableInteractorOutput!
    
    var coordinateService: CoordinatesServiceType!
    
    func loadCoordinates() {
        coordinateService.loadCoordinates().then { (coordinates) -> Void in
            self.output.coordinatesLoaded(coordinates)
        }
    }
    
    func removeCoordinate(coordinate: Coordinate) {
        coordinateService.deleteCoordinate(coordinate).then { coord in
            self.output.coordinateRemoved(coord)
        }
    }
    
    func updateCoordinate(coordinate: Coordinate) {
        coordinateService.updateCoordinate(coordinate).then { (coord) -> Void in
            self.output.coordinateUpdated(coord)
        }
    }
    
    func getCurrentCoords(coordinate: Coordinate) {
        coordinateService.getCurrentCoordinate(coordinate).then { (coord) -> Void in
            self.output.coordinateGot(coord)
        }
    }

    
    func saveCoordinate(coordinate: Coordinate) {
        coordinateService.saveCoordinate(coordinate).then { (coord) -> Void in
            self.output.coordinateGot(coord)
        }
    }

}
