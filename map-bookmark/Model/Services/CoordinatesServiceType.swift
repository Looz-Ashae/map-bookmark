//
//  CoordinatesServiceType.swift
//  map-bookmark
//
//  Created by Admin on 08.01.17.
//  Copyright © 2017 rizer. All rights reserved.
//

import Foundation
import PromiseKit

protocol CoordinatesServiceType {
    
    func saveCoordinate(coord: Coordinate) -> Promise<Coordinate>
    func deleteCoordinate(coord: Coordinate) -> Promise<Coordinate>
    func updateCoordinate(coord: Coordinate) -> Promise<Coordinate>
    func getCurrentCoordinate(coord: Coordinate) -> Promise<Coordinate>
    func loadCoordinates() -> Promise<[Coordinate]>
}
