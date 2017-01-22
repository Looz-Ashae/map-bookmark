//
//  UIViewController+TransitionHandler.swift
//  map-bookmark
//
//  Created by rizer on 25/12/2016.
//  Copyright © 2016 com.rizer. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController, TransitionHandler {
    class ConfigurationBlockHolder {
        let block: (ModuleInput) -> Void
        
        init(block: (ModuleInput) -> Void) {
            self.block = block
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if ((self.navigationController?.respondsToSelector(Selector("interactivePopGestureRecognizer"))) != nil) {
            self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        }
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        if ((self.navigationController?.respondsToSelector(Selector("interactivePopGestureRecognizer"))) != nil) {
            self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let configurationBlock = sender as? ConfigurationBlockHolder {
            if let destinationController = segue.destinationViewController as? UINavigationController {
                guard let controller = destinationController.topViewController as? ModuleInputProvider else {
                    fatalError("Controller should be Module Input provider")
                }
                configurationBlock.block(controller.moduleInput)
                return
            }
            
            guard let controller = segue.destinationViewController as? ModuleInputProvider else {
                fatalError("Controller should be Module Input provider")
            }
            configurationBlock.block(controller.moduleInput)
        }
    }
    
    func openModule(segueIdentifier: String) {
        performSegueWithIdentifier(segueIdentifier, sender: nil)
    }
    
    func openModule(segueIdentifier: String, configurationBlock: ConfigurationBlock) {
        performSegueWithIdentifier(segueIdentifier, sender: BaseViewController.ConfigurationBlockHolder(block: configurationBlock))
    }
    
    func closeCurrentModule() {
        if let parentViewController = self.parentViewController {
            let isNavigationStack = parentViewController is UINavigationController
            let hasManyControllersInStack = isNavigationStack ? parentViewController.childViewControllers.count > 0 : false
            
            if isNavigationStack && hasManyControllersInStack {
                let navigationController = parentViewController as! UINavigationController
                navigationController.popViewControllerAnimated(true)
            }
        }
    }
    
}

extension BaseViewController : UIGestureRecognizerDelegate {
    
}
