//
//  SwipeMenuDelegate.swift
//  map-bookmark
//
//  Created by Admin on 21.01.17.
//  Copyright © 2017 rizer. All rights reserved.
//

import Foundation

protocol SwipeMenuDelegate: class {
    func swipeMenuButtonClickedOfType(type: SwipeButtonType, andID id: Int)
}
