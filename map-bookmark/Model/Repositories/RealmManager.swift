//
//  RealmManager.swift
//  map-bookmark
//
//  Created by Admin on 08.01.17.
//  Copyright © 2017 rizer. All rights reserved.
//

import Foundation
import RealmSwift
import PromiseKit

class RealmManager: RealmManagerType {
    
    func getRealm() -> Realm {
        return try! Realm()
    }
    
    func loadCoordinates() -> Promise<[Coordinate]> {
        var dict : [Coordinate] = []
        return Promise { fulfill, reject in
            let coords = getRealm().objects(RCoordinate.self)
            for coord in coords {
                dict.append(Coordinate(dbCoordinate: coord))
            }
            fulfill(dict)
        }
    }
    
    func updateCoordinate(coord: Coordinate) -> Promise<Coordinate> {
        let realm = getRealm()
        
        let rCoordinate = RCoordinate()

        rCoordinate.construct(coord)
        return Promise {fulfill, reject in
            do {
                try realm.write {
                    realm.add(rCoordinate, update: true)
                    fulfill(coord)
                }
            } catch {
                reject(error)
            }
        }
    }
    
    
    func addCoordinate(coord: Coordinate) -> Promise<Coordinate> {
        let realm = getRealm()
        
        let rCoordinate = RCoordinate()
        coord.id = rCoordinate.incrementID()
        rCoordinate.construct(coord)
        
        return Promise {fulfill, reject in
            do {
                try realm.write {
                    realm.add(rCoordinate)
                    coord.id = rCoordinate.id
                    fulfill(coord)
                }
            } catch {
                reject(error)
            }
        }
    }
    
    func removeCoordinate(coord: Coordinate) -> Promise<Coordinate> {
        let realm = getRealm()
        return Promise { fulfill, reject in
            guard let rCoordinate = getRealm().objects(RCoordinate.self).filter(NSPredicate(format: "id == \(coord.id)")).first
                else {
                reject(RealmError.NoDataQueried)
                    return
            }
            do {
                try realm.write {
                    realm.delete(rCoordinate)
                    fulfill(coord)
                }
            } catch {
                reject(error)
            }
        }
    }

}
