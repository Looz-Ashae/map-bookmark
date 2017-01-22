//
//  MBMainTableMBMainTableInteractorInput.swift
//  map-bookmark
//
//  Created by rizer on 03/01/2017.
//  Copyright © 2017 com.rizer. All rights reserved.
//

import Foundation

protocol MainTableInteractorInput {
    func getCurrentCoords(coordinate: Coordinate)
    func saveCoordinate(coordinate: Coordinate)
    func loadCoordinates()
    func removeCoordinate(coordinate: Coordinate)
    func updateCoordinate(coordinate: Coordinate)
}
