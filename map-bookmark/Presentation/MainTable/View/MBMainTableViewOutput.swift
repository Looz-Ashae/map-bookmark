//
//  MainTableMBMainTableViewOutput.swift
//  map-bookmark
//
//  Created by rizer on 03/01/2017.
//  Copyright © 2017 com.rizer. All rights reserved.
//

protocol MainTableViewOutput {

    /**
        @author rizer
        Notify presenter that view is ready
    */

    func viewIsReady()
    func addButtonClicked(button: AddButton)
    func getCoordinate(coord: Coordinate)
    func saveCoordinate(coord: Coordinate)
    func coordinateInputError(error: InputErrors)
    func cellSentDeleteMessageWithRowId(id: Int)
    func cellSentEditMessageWithRowId(id: Int)
    func removeBookmarkOfCoordinate(coordinate: Coordinate)
    func editBookmarkOfCoordinate(coordinate: Coordinate)
    func coordinateSelected(coord: Coordinate)
}
