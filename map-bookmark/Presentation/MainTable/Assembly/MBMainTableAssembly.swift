//
//  MBMainTableMBMainTableAssembly.swift
//  map-bookmark
//
//  Created by rizer on 03/01/2017.
//  Copyright © 2017 com.rizer. All rights reserved.
//

import UIKit
import Swinject

class MainTableModuleAssembly: ViperModuleAssembly {
    required init() {}

    func assemble(container: Container) {
        // View
        container.registerForStoryboard(MainTableViewController.self) { (r, c) in
            c.output = r.resolve(MainTableModuleInput.self, argument: c) as! MainTableViewOutput
        }
        
        // Presenter
        container.register(MainTableModuleInput.self) { (r, c: MainTableViewController) in
            let presenter =  MainTablePresenter()
            presenter.view = c
            return presenter
        }.initCompleted { (r, p) in
            let p = p as! MainTablePresenter

            p.router = r.resolve(MainTableRouterInput.self, argument: p.view as! TransitionHandler)
            p.interactor = r.resolve(MainTableInteractorInput.self, argument: p as MainTableInteractorOutput)
        }
        
        // Router
        container.register(MainTableRouterInput.self) { (r, v: TransitionHandler) in
            let router = MainTableRouter()
            router.transitionHandler = v
            return router
        }

        // Interactor
        container.register(MainTableInteractorInput.self) { (r, p: MainTableInteractorOutput) in
            let interactor =  MainTableInteractor()
            interactor.output = p
            interactor.coordinateService = r.resolve(CoordinatesServiceType.self)
            return interactor
        }
    }
}

