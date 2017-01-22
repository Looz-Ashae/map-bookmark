//
//  MapMBMapViewOutput.swift
//  map-bookmark
//
//  Created by rizer on 18/01/2017.
//  Copyright © 2017 com.rizer. All rights reserved.
//

protocol MapViewOutput {

    /**
        @author rizer
        Notify presenter that view is ready
    */

    func viewIsReady()
    func mapTappedWithCoordinate(coordinate: Coordinate)
    func annotationAdded(coordinate: Coordinate)
}
