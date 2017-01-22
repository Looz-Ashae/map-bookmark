//
//  MapMBMapViewInput.swift
//  map-bookmark
//
//  Created by rizer on 18/01/2017.
//  Copyright © 2017 com.rizer. All rights reserved.
//

protocol MapViewInput: class {

    /**
        @author rizer
        Setup initial state of the view
    */

    func setupInitialState()
    func setCenterAnnotationWithCoordinate(coordinate: Coordinate)
    func centerMap(coordinate: Coordinate)
    func putAnnotationToCoordinate(coordinate: Coordinate)
    func showAnnotationAdditionDialog(coordinate: Coordinate)
}
