//
//  MapMBMapRouter.swift
//  map-bookmark
//
//  Created by rizer on 18/01/2017.
//  Copyright © 2017 com.rizer. All rights reserved.
//

class MapRouter: MapRouterInput {
	weak var transitionHandler: TransitionHandler!
    
    func backToTable() {
        transitionHandler.closeCurrentModule()
    }
}
