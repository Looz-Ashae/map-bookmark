//
//  Functions.swift
//  map-bookmark
//
//  Created by Admin on 21.01.17.
//  Copyright © 2017 rizer. All rights reserved.
//

import Foundation

class Functions {

    class func binarySearch<T : Comparable>(array: [T], target: T) -> Int {
        var left = 0
        var right = array.count - 1
        
        while (left <= right) {
            let mid = (left + right) / 2
            let value = array[mid]
            
            if (value == target) {
                return mid
            }
            
            if (value < target) {
                left = mid + 1
            }
            
            if (value > target) {
                right = mid - 1
            }
        }
        
        return 0
    }
}
