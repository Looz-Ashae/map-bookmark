//
//  ModelAssembly.swift
//  map-bookmark
//
//  Created by Admin on 28.12.16.
//  Copyright © 2016 rizer. All rights reserved.
//

import Foundation
import Swinject

class ModelAssembly: AssemblyType {
    func assemble(container: Container) {
        container.register(RealmManagerType.self) { (_) in
            return RealmManager()
            }.inObjectScope(.Container)
        container.register(GeoLocationRepositoryType.self) { (r) in
            return GeoLocationRepository()
        }.inObjectScope(.Container)
        container.register(CoordinatesDBRepositoryType.self) { (r) in
            return CoordinatesDBRepository(realmManager: r.resolve(RealmManagerType.self)!)
        }.inObjectScope(.Container)
        container.register(CoordinatesServiceType.self) { (r) in
            return CoordinatesService(dbManager: r.resolve( CoordinatesDBRepositoryType.self)!, geoLocRepo: r.resolve(GeoLocationRepositoryType.self)!)
        }
    }
}
