//
//  MainTableMBMainTableRouter.swift
//  map-bookmark
//
//  Created by rizer on 03/01/2017.
//  Copyright © 2017 com.rizer. All rights reserved.
//

class MainTableRouter: MainTableRouterInput {
	weak var transitionHandler: TransitionHandler!
    
    func openMapWithConfigurationBlock(block: (MapModuleInput) -> Void) {
        transitionHandler.openModule("to_map") { (input) in
            guard let moduleInput = input as? MapModuleInput else {
                fatalError("Wrong module input")
            }
            block(moduleInput)
        }
    }
}
