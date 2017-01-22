//
//  EmbedSegue.swift
//  map-bookmark
//
//  Created by rizer on 25/12/2016.
//  Copyright © 2016 com.rizer. All rights reserved.
//

import UIKit
import PureLayout

protocol EmbedViewProvider {
    func viewForEmbedWithIdentifier(identifier: String) -> UIView?
}

class EmbedSegue: UIStoryboardSegue {
    override func perform() {
        guard let provider = sourceViewController as? EmbedViewProvider else {
            fatalError("Source vc should be Embed view provider")
        }
        
        guard let identifier = identifier, let view = provider.viewForEmbedWithIdentifier(identifier) else {
            fatalError("No view for embed segue")
        }
        
        destinationViewController.willMoveToParentViewController(sourceViewController)
        sourceViewController.addChildViewController(destinationViewController)
        view.addSubview(destinationViewController.view)
        destinationViewController.view.autoPinEdgesToSuperviewEdges()
//        destinationViewController.view.snp_makeConstraints { (make) in
//            make.edges.equalTo(view)
//        }
        destinationViewController.didMoveToParentViewController(sourceViewController)
    }
}
