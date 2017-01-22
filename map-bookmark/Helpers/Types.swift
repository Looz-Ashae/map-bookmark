//
//  Types.swift
//  map-bookmark
//
//  Created by rizer on 25/12/2016.
//  Copyright © 2016 com.rizer. All rights reserved.
//

import UIKit
import Foundation

typealias textfield_configuration_block_t = (textField: UITextField) -> Void
typealias alert_action_block_t = (action: UIAlertAction) -> Void

let IS_IPAD = (UI_USER_INTERFACE_IDIOM() == .Pad)
let IS_IPHONE = (UI_USER_INTERFACE_IDIOM() == .Phone)
let IS_RETINA = (UIScreen.mainScreen().scale >= 2.0)
let SCREEN_WIDTH = (UIScreen.mainScreen().bounds.size.width)
let SCREEN_HEIGHT = (UIScreen.mainScreen().bounds.size.height)
let SCREEN_MAX_LENGTH = (max(SCREEN_WIDTH, SCREEN_HEIGHT))
let SCREEN_MIN_LENGTH = (min(SCREEN_WIDTH, SCREEN_HEIGHT))
let IS_IPHONE_4_OR_LESS = (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
let IS_IPHONE_5 = (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
let IS_IPHONE_6 = (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
let IS_IPHONE_6P = (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)

extension UIColor {
    class func rgba(red: Float,_ green: Float,_ blue: Float,_ alpha: Float) -> UIColor{
        return UIColor.init(colorLiteralRed: red/255.0, green: green/255.0, blue: blue/255.0, alpha: alpha)
    }
    
    class func rgb(red: Float,_ green: Float,_ blue: Float) -> UIColor{
        return UIColor.init(colorLiteralRed: red/255.0, green: green/255.0, blue: blue/255.0, alpha: 1.0)
    }
}

extension String {
    static func localized(input: String) -> String {
        return NSLocalizedString(input, comment: "")
    }
}
