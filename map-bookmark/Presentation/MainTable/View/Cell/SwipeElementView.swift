//
//  SwipeElement.swift
//  map-bookmark
//
//  Created by Admin on 21.01.17.
//  Copyright © 2017 rizer. All rights reserved.
//

import UIKit

class SwipeElementView: UIView {


    @IBOutlet var vie: UIView!
    @IBOutlet weak var button: UIButton!
    var type: SwipeButtonType!
    weak var swipeButtonDelegate: SwipeMenuButtonDelegate?

    convenience init(frame: CGRect, type: SwipeButtonType) {
        self.init(frame: frame)
        NSBundle.mainBundle().loadNibNamed("SwipeElementView", owner: self, options: nil)
        self.addSubview(vie)
        self.type = type
    }
    
    func setImage(image: UIImage) {
        self.button.setImage(image, forState: .Normal)
        self.button.backgroundColor = UIColor.rgb(0, 205, 205)
    }

    @IBAction func buttonClicked(sender: AnyObject) {
        swipeButtonDelegate?.swipeMenuButtonClickedOfType(type)
    }
}
