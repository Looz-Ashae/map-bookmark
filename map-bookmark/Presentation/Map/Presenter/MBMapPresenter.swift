//
//  MapMBMapPresenter.swift
//  map-bookmark
//
//  Created by rizer on 18/01/2017.
//  Copyright © 2017 com.rizer. All rights reserved.
//

class MapPresenter {
    weak var view: MapViewInput!
    var interactor: MapInteractorInput!
    var router: MapRouterInput!
    var shouldMarkCoordinate: Bool = false
    var startingCoordinate: Coordinate!
    private var mainTableModuleInput: MainTableModuleInput!
}

// MARK: - Module Input
extension MapPresenter: MapModuleInput {
    func setTableModuleInput(tableModuleInput: MainTableModuleInput) {
        self.mainTableModuleInput = tableModuleInput
    }
    
    func shouldPresentCoordinate(flag: Bool) {
        self.shouldMarkCoordinate = flag
    }
    
    func setStartingCoordinate(coord: Coordinate) {
        self.startingCoordinate = coord
    }
}

// MARK: - View Output
extension MapPresenter: MapViewOutput {
    func viewIsReady() {
        view.setupInitialState()
        if shouldMarkCoordinate {
            view.setCenterAnnotationWithCoordinate(startingCoordinate)
        }
    }
    
    func mapTappedWithCoordinate(coordinate: Coordinate) {
        view.showAnnotationAdditionDialog(coordinate)
    }
    
    func annotationAdded(coordinate: Coordinate) {
        interactor.saveCoordinate(coordinate)
    }
}

// MARK: - Interactor Output
extension MapPresenter: MapInteractorOutput {
    func encounteredError(error: ErrorType) {
    	
	}
    
    func coordinateSaved(coordinate: Coordinate) {
        mainTableModuleInput.showNewCoordinate(coordinate)
    }
}
