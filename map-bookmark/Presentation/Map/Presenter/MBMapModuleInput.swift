//
//  MapMBMapModuleInput.swift
//  map-bookmark
//
//  Created by rizer on 18/01/2017.
//  Copyright © 2017 com.rizer. All rights reserved.
//

protocol MapModuleInput: class, ModuleInput {
    func setTableModuleInput(tableModuleInput: MainTableModuleInput)
    func shouldPresentCoordinate(flag: Bool)
    func setStartingCoordinate(coord: Coordinate)
}
