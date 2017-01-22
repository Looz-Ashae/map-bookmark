//
//  MBMapMBMapAssembly.swift
//  map-bookmark
//
//  Created by rizer on 18/01/2017.
//  Copyright © 2017 com.rizer. All rights reserved.
//

import UIKit
import Swinject

class MapModuleAssembly: ViperModuleAssembly {
    required init() {}

    func assemble(container: Container) {
        // View
        container.registerForStoryboard(MapViewController.self) { (r, c) in
            c.output = r.resolve(MapModuleInput.self, argument: c) as! MapViewOutput
        }
        
        // Presenter
        container.register(MapModuleInput.self) { (r, c: MapViewController) in
            let presenter =  MapPresenter()
            presenter.view = c
            return presenter
        }.initCompleted { (r, p) in
            let p = p as! MapPresenter
            
            p.router = r.resolve(MapRouterInput.self, argument: p.view as! TransitionHandler)
            p.interactor = r.resolve(MapInteractorInput.self, argument: p as MapInteractorOutput)
        }
        
        // Router
        container.register(MapRouterInput.self) { (r, v: TransitionHandler) in
            let router = MapRouter()
            router.transitionHandler = v
            return router
        }

        // Interactor
        container.register(MapInteractorInput.self) { (r, p: MapInteractorOutput) in
            let interactor =  MapInteractor()
            interactor.output = p
            interactor.coordinateService = r.resolve(CoordinatesServiceType.self)
            return interactor
        }
    }
}

