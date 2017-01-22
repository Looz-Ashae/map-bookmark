//
//  MainTableMBMainTableViewInput.swift
//  map-bookmark
//
//  Created by rizer on 03/01/2017.
//  Copyright © 2017 com.rizer. All rights reserved.
//

protocol MainTableViewInput: class {

    /**
        @author rizer
        Setup initial state of the view
    */

    func setupInitialState()
    func reloadTableWithData(data: [Coordinate])
    func showSaveCurrentCoordsDialog(name: String, description: String)
    func showSaveCoordsDialog(name: String, description: String)
    func showInputErrorDialog(name: String, description: String)
    func showDeleteCellDialogWithID(id: Int, name: String, description: String)
    func showEditCellDialogWithID(id: Int, name: String, description: String)
}
