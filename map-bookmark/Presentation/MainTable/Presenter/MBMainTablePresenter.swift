//
//  MainTableMBMainTablePresenter.swift
//  map-bookmark
//
//  Created by rizer on 03/01/2017.
//  Copyright © 2017 com.rizer. All rights reserved.
//

class MainTablePresenter {
    weak var view: MainTableViewInput!
    var interactor: MainTableInteractorInput!
    var router: MainTableRouterInput!
    var coordinates: [Coordinate]!

}

// MARK: - Module Input
extension MainTablePresenter: MainTableModuleInput {
    func showNewCoordinate(coordinate: Coordinate) {
        coordinates.append(coordinate)
        view.reloadTableWithData(coordinates)
    }
}

// MARK: - View Output
extension MainTablePresenter: MainTableViewOutput {
    func viewIsReady() {
        interactor.loadCoordinates()
        view.setupInitialState()
    }
    
    func coordinateSelected(coord: Coordinate) {
        router.openMapWithConfigurationBlock { (mapModule) in
            mapModule.shouldPresentCoordinate(true)
            mapModule.setStartingCoordinate(coord)
        }
    }
    
    func editBookmarkOfCoordinate(coordinate: Coordinate) {
        interactor.updateCoordinate(coordinate)
    }
    
    func removeBookmarkOfCoordinate(coordinate: Coordinate) {
        interactor.removeCoordinate(coordinate)
    }
    
    func cellSentDeleteMessageWithRowId(id: Int) {
        view.showDeleteCellDialogWithID(id, name: "Delete boorkmark", description: "Are you sure you want to delete this bookmark?")
    }
    
    func cellSentEditMessageWithRowId(id: Int) {
        view.showEditCellDialogWithID(id, name: "Edit bookmark", description: "Provide new data for editing")
    }
    
    func addButtonClicked(button: AddButton) {
        switch button {
        case .coordinates:
            view.showSaveCoordsDialog("Give name, description of the bookmark and input the coordinate", description: "")
            break
        case .current:
            view.showSaveCurrentCoordsDialog("Give name and description of the bookmark", description: "")
            break
        case .onMap:
            router.openMapWithConfigurationBlock({ mapInput in
                mapInput.setTableModuleInput(self)
            })
            break
        default:
            break
        }
    }
    
    func coordinateInputError(error: InputErrors) {
        switch error {
        case .latitude:
            view.showInputErrorDialog("Input error", description: InputErrors.latitude.rawValue)
        case .longitude:
            view.showInputErrorDialog("Input error", description: InputErrors.longitude.rawValue)
        }
    }
    
    func getCoordinate(coord: Coordinate) {
        interactor.getCurrentCoords(coord)
    }
    
    func saveCoordinate(coord: Coordinate) {
        interactor.saveCoordinate(coord)
    }
    
}

// MARK: - Interactor Output
extension MainTablePresenter: MainTableInteractorOutput {
    func encounteredError(error: ErrorType) {
    	
	}
    
    func coordinateGot(coord: Coordinate) {
        self.coordinates.append(coord)
        view.reloadTableWithData(coordinates)
    }
    
    func coordinatesLoaded(coordinates: [Coordinate]) {
        self.coordinates = coordinates
        view.reloadTableWithData(coordinates)
        
    }
    
    func coordinateRemoved(coord: Coordinate) {
        coordinates.removeAtIndex(Functions.binarySearch(coordinates, target: coord))
        view.reloadTableWithData(coordinates)
    }
    
    func coordinateUpdated(coord: Coordinate) {
        coordinates[Functions.binarySearch(coordinates, target: coord)] = coord
        view.reloadTableWithData(coordinates)
    }
}
