//
//  MBMapMBMapInteractor.swift
//  map-bookmark
//
//  Created by rizer on 18/01/2017.
//  Copyright © 2017 com.rizer. All rights reserved.
//

class MapInteractor: MapInteractorInput {

    weak var output: MapInteractorOutput!
    var coordinateService: CoordinatesServiceType!
    
    func saveCoordinate(coordinate: Coordinate) {
        coordinateService.saveCoordinate(coordinate).then { (coord) -> Void in
            self.output.coordinateSaved(coord)
        }
    }

}
