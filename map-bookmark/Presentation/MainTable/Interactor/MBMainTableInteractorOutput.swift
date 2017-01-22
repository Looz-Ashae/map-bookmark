//
//  MBMainTableMBMainTableInteractorOutput.swift
//  map-bookmark
//
//  Created by rizer on 03/01/2017.
//  Copyright © 2017 com.rizer. All rights reserved.
//

import Foundation

protocol MainTableInteractorOutput: class {
	func encounteredError(error: ErrorType)
    func coordinateGot(coord: Coordinate)
    func coordinateUpdated(coord: Coordinate)
    func coordinateRemoved(coord: Coordinate)
    func coordinatesLoaded(coordinates: [Coordinate])
}
