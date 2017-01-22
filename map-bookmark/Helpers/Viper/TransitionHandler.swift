//
//  TransitionHandler.swift
//  map-bookmark
//
//  Created by rizer on 25/12/2016.
//  Copyright © 2016 com.rizer. All rights reserved.
//

typealias ConfigurationBlock = (ModuleInput) -> Void

protocol TransitionHandler: class {
    func openModule(segueIdentifier: String)
    func openModule(segueIdentifier: String, configurationBlock: ConfigurationBlock)
    func closeCurrentModule()
}
