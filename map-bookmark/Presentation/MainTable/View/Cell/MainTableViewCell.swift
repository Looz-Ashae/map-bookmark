//
//  MainTableViewCell.swift
//  map-bookmark
//
//  Created by Admin on 04.01.17.
//  Copyright © 2017 rizer. All rights reserved.
//

import UIKit
import MGSwipeTableCell

class MainTableViewCell: MGSwipeTableCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    weak var swipeMenuDelegate: SwipeMenuDelegate?
    var id: Int!
    
    override func prepareForReuse() {
        self.rightButtons = []
    }
    
    func setElements(title: String, subTitle: String) {
        self.title.text = title
        self.subTitle.text = subTitle
        let deleteButton = SwipeElementView(frame: CGRect(origin: CGPointZero, size: CGSize(width: self.frame.height, height: self.frame.height)), type: SwipeButtonType.Delete)
        deleteButton.setImage(UIImage(named: "delete-512")!)
        deleteButton.swipeButtonDelegate = self
        self.rightButtons.append(deleteButton)
        let editButton = SwipeElementView(frame: CGRect(origin: CGPointZero, size: CGSize(width: self.frame.height, height: self.frame.height)), type: .Edit)
        editButton.setImage(UIImage(named: "edit-2-512")!)	
        editButton.swipeButtonDelegate = self
        self.rightButtons.append(editButton)
    }
    
}

extension MainTableViewCell: SwipeMenuButtonDelegate {
    func swipeMenuButtonClickedOfType(type: SwipeButtonType) {
        swipeMenuDelegate?.swipeMenuButtonClickedOfType(type, andID: id)
    }
}
