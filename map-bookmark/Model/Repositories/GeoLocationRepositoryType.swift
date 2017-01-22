//
//  CoreLocationRepositoryType.swift
//  map-bookmark
//
//  Created by Admin on 22.01.17.
//  Copyright © 2017 rizer. All rights reserved.
//

import Foundation
import PromiseKit

protocol GeoLocationRepositoryType {
    func getCurrentCoordinate(coordinate: Coordinate) -> Promise<Coordinate>
}
