//
//  MBMapMBMapInteractorOutput.swift
//  map-bookmark
//
//  Created by rizer on 18/01/2017.
//  Copyright © 2017 com.rizer. All rights reserved.
//

import Foundation

protocol MapInteractorOutput: class {
	func encounteredError(error: ErrorType)
    func coordinateSaved(coordinate: Coordinate)
}
