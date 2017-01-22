//
//  MainTableMBMainTableRouterInput.swift
//  map-bookmark
//
//  Created by rizer on 03/01/2017.
//  Copyright © 2017 com.rizer. All rights reserved.
//

import Foundation

protocol MainTableRouterInput {
    func openMapWithConfigurationBlock(block: (MapModuleInput) -> Void)
}
