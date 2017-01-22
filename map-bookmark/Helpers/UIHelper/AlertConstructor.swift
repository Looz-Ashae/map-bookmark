//
//  AlertConstructor.swift
//  map-bookmark
//
//  Created by Admin on 17.01.17.
//  Copyright © 2017 rizer. All rights reserved.
//

import Foundation
import UIKit

class AlertControllerConstructor {
    private var title : String!
    private var message: String!
    private var style: UIAlertControllerStyle!
    private var actions : [Int : UIAlertAction]!
    private var textFieldConfigurations : [Int : ConfigurationWrapper]!
    private var order : Int = 0
    private var alert : UIAlertController!
    private var textFields: [UITextField]?
    var TextFields : [UITextField]! {
        get {
            return textFields
        }
        set {
            textFields = newValue
        }
    }
    
    class ConfigurationWrapper {
        var handler : textfield_configuration_block_t!
        init(handler : textfield_configuration_block_t) {
            self.handler = handler
        }
    }
    
    init(style: UIAlertControllerStyle, title : String, message : String) {
        self.style = style
        self.title = title
        self.message = message
        self.actions = [:]
        self.textFieldConfigurations = [:]
        self.textFields = []
        self.alert = UIAlertController(title: self.title, message: self.message, preferredStyle: self.style)
    }
    
    func addButton(action: UIAlertAction) {
        self.actions[order] = action
        order += 1
    }
    
    func addTextFieldWithConfigurationHandler(handler: textfield_configuration_block_t) {
        self.textFieldConfigurations[order] = ConfigurationWrapper(handler: handler)
        order += 1
    }
    
    func buildAlertController() -> UIAlertController {
        var object = 0
        while object < order {
            if actions[object] != nil {
                alert.addAction(actions[object]!)
            } else if textFieldConfigurations[object] != nil {
                alert.addTextFieldWithConfigurationHandler(textFieldConfigurations[object]?.handler)
            }
            object += 1
        }
        self.textFields = alert.textFields
        alert.view.tintColor = UIColor.blackColor()
        return alert
    }
    
}

