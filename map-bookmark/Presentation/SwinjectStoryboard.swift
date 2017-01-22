//
//  SwinjectStoryboard.swift
//  map-bookmark
//
//  Created by Admin on 28.12.16.
//  Copyright © 2016 rizer. All rights reserved.
//

import Foundation
import Swinject

class AssemblerHolder {
    static let sharedAssembler = Assembler(container: SwinjectStoryboard.defaultContainer)
}

class ViperAssembler<T: ViperModuleAssembly>: Assembler {
    init() {
        super.init(container: SwinjectStoryboard.defaultContainer)
        
        self.applyAssembly(T())
    }
}

protocol ViperModuleAssembly: AssemblyType {
    init()
}

extension SwinjectStoryboard {
    public static func setup() {
        AssemblerHolder.sharedAssembler.applyAssemblies([ModelAssembly()])
    }
}
