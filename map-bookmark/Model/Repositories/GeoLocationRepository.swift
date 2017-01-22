//
//  CoreLocationRepository.swift
//  map-bookmark
//
//  Created by Admin on 22.01.17.
//  Copyright © 2017 rizer. All rights reserved.
//

import Foundation
import PromiseKit
import SwiftLocation

class GeoLocationRepository: GeoLocationRepositoryType {
    func getCurrentCoordinate(coordinate: Coordinate) -> Promise<Coordinate> {
        return Promise { fulfill, reject in
            Location.getLocation(withAccuracy: .Navigation, onSuccess: { (foundLocation) in
                coordinate.latitude = foundLocation.coordinate.latitude
                coordinate.longitude = foundLocation.coordinate.longitude
                fulfill(coordinate)
                }) { (lastValidLocation, error) in
                    guard let location = lastValidLocation else {
                        reject(error)
                        return
                    }
                    coordinate.latitude = location.coordinate.latitude
                    coordinate.longitude = location.coordinate.longitude
                    reject(error)
            }
        }
    }
}
