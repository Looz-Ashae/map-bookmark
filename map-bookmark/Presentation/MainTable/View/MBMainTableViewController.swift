//
//  MainTableMBMainTableViewController.swift
//  map-bookmark
//
//  Created by rizer on 03/01/2017.
//  Copyright © 2017 com.rizer. All rights reserved.
//
import Foundation
import UIKit
import LGPlusButtonsView
import PromiseKit
import MGSwipeTableCell

class MainTableViewController: BaseViewController {
    weak var assembler = ViperAssembler<MainTableModuleAssembly>()
    
    @IBOutlet weak var table: UITableView!
    var buttonPlus : LGPlusButtonsView!
    var coordinates: [Coordinate]!

    var output: MainTableViewOutput!

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBarHidden = true
    }
    
    private func showDialogWithMainText(mainText: String, secondaryText secText: String) {
        let alert = PMKAlertController(title: mainText, message: secText, preferredStyle: .Alert)
        alert.addActionWithTitle("Ок", style: .Default)
        self.promiseViewController(alert)
    }
    
    private func showDialogWithActionHandler(actionHandler: alert_action_block_t, mainText: String, secondaryText secText: String) {
        let alert = AlertControllerConstructor(style: .Alert, title: mainText, message: secText)
        let okAction = UIAlertAction(title: "Ok", style: .Default, handler: actionHandler)
        alert.addButton(okAction)
        alert.addButton(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        self.presentViewController(alert.buildAlertController(), animated: true, completion: nil)
    }

}

extension MainTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coordinates.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCellWithIdentifier("main_cell", forIndexPath: indexPath) as! MainTableViewCell
        cell.setElements(coordinates[indexPath.row].name, subTitle: coordinates[indexPath.row].coordDescription)
        cell.delegate = self
        cell.swipeMenuDelegate = self
        cell.id = indexPath.row
        return cell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! MainTableViewCell
        cell.selected = false
        output.coordinateSelected(coordinates[indexPath.row])
    }
    
    
}

extension MainTableViewController : MGSwipeTableCellDelegate {
    func swipeTableCell(cell: MGSwipeTableCell, canSwipe direction: MGSwipeDirection) -> Bool {
        return true
    }
}

extension MainTableViewController: SwipeMenuDelegate {
    
    func swipeMenuButtonClickedOfType(type: SwipeButtonType, andID id: Int) {
        switch type {
        case .Delete:
            output.cellSentDeleteMessageWithRowId(id)
        case .Edit:
            output.cellSentEditMessageWithRowId(id)
        }
    }
}

// MARK: - View Input
extension MainTableViewController: MainTableViewInput {
    func setupInitialState() {
        buttonPlus = LGPlusButtonsView(numberOfButtons: 4,
                                       firstButtonIsPlusButton: true,
                                       showAfterInit: true,
                                       actionHandler: { (view, title, description, ind) in
                                        self.output.addButtonClicked(AddButton(rawValue: Int(ind))!)
            }
        )
        buttonPlus.setButtonsEnabled(true)
        buttonPlus.observedScrollView = table
        buttonPlus.hideButtonsOnScroll = true
        buttonPlus.plusButtonAnimationType = .Rotate
        
        buttonPlus.backgroundColor = .clearColor()
        buttonPlus.showHideOnScroll = true;
        buttonPlus.appearingAnimationType = .CrossDissolveAndPop;
        buttonPlus.setButtonsImageViewContentMode(.Center)
        buttonPlus.setButtonsBackgroundColor(.rgb(0,205,205), forState: .Normal)
        buttonPlus.setButtonsLayerCornerRadius(21, forOrientation: .Portrait)
        buttonPlus.setButtonsLayerShadowOffset(CGSize(width: 0.0, height: 0.0))
        buttonPlus.setButtonsTitleColor(.whiteColor(), forState: .Normal)
        buttonPlus.setButtonsTitleFont(UIFont.init(name: "Helvetica Neue", size: 30), forOrientation: .Portrait)
        buttonPlus.setButtonsTitleOffset(CGPoint(x: 0, y: -4), forOrientation: .Portrait)
        buttonPlus.setButtonsSize(CGSize(width: 42,height: 42), forOrientation: .Portrait)
        buttonPlus.setButtonsLayerShadowColor(.blackColor())
        buttonPlus.setButtonsLayerShadowRadius(6.0)
        buttonPlus.setButtonsLayerShadowOpacity(0.5)
        var buttonImages : Array<UIImage> = []
        buttonImages.append(UIImage())
        buttonImages.append(UIImage(named: "add-row-512")!)
        buttonImages.append(UIImage(named: "worldwide-location-512")!)
        buttonImages.append(UIImage(named: "map-marker-2-512")!)
        buttonPlus.setButtonsImages(buttonImages, forState: .Normal, forOrientation: .Portrait)
        buttonPlus.setButtonsEnabled(true)
        buttonPlus.hidden = false
        buttonPlus.setButtonsTitles(["+","","",""], forState: .Normal)
        buttonPlus.setDescriptionsTexts(["",
            "Current location",
            "Choose on map",
            "Input coordinates"])
        self.view.addSubview(buttonPlus)
        buttonPlus.showAnimated(true) { 
            
        }
        coordinates = []
        table.tableFooterView = UIView()
        table.registerNib(UINib(nibName: "MainTableViewCell", bundle: nil),
                          forCellReuseIdentifier: "main_cell")

    }
    
    func reloadTableWithData(data: [Coordinate]) {
        coordinates = data
        table.reloadData()
    }
    
    func showEditCellDialogWithID(id: Int, name: String, description: String) {
        let alert = AlertControllerConstructor(style: .Alert, title: name, message: description)
        alert.addTextFieldWithConfigurationHandler { (textField) in
            textField.text = self.coordinates[id].name
        }
        alert.addTextFieldWithConfigurationHandler { (textField) in
            textField.text = self.coordinates[id].coordDescription
        }
        let okAction = UIAlertAction(title: "Ok", style: .Default, handler: { (action) in
            let coordinate = self.coordinates[id]
            if let name = alert.TextFields[0].text {
                coordinate.name = name
            } else {
                return
            }
            if let description = alert.TextFields[1].text {
                coordinate.coordDescription = description
            }else {
                return
            }
            self.output.editBookmarkOfCoordinate(coordinate)
        })
        alert.addButton(okAction)
        alert.addButton(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        self.presentViewController(alert.buildAlertController(), animated: true, completion: nil)
    }
    
    func showDeleteCellDialogWithID(id: Int, name: String, description: String) {
        let okAction : alert_action_block_t = { action in
            self.output.removeBookmarkOfCoordinate(self.coordinates[id])
        }
        self.showDialogWithActionHandler(okAction, mainText: name, secondaryText: description)
    }
    
    func showSaveCurrentCoordsDialog(name: String, description: String) {
        let alert = AlertControllerConstructor(style: .Alert, title: name, message: description)
        alert.addTextFieldWithConfigurationHandler { (textField) in
            textField.placeholder = "Input name"
        }
        alert.addTextFieldWithConfigurationHandler { (textField) in
            textField.placeholder = "Input description"
        }
        let okAction = UIAlertAction(title: "Ok", style: .Default, handler: { (action) in
            let coordinate = Coordinate()
            guard let name = alert.TextFields[0].text else {
                return
            }
            coordinate.name = name
            guard let description = alert.TextFields[1].text else {
                return
            }
            coordinate.coordDescription = description
            self.output.getCoordinate(coordinate)
        })
        alert.addButton(okAction)
        alert.addButton(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        self.presentViewController(alert.buildAlertController(), animated: true, completion: nil)
    }

    func showSaveCoordsDialog(name: String, description: String) {
        let alert = AlertControllerConstructor(style: .Alert, title: name, message: description)
        alert.addTextFieldWithConfigurationHandler { (textField) in
            textField.placeholder = "Input name"
        }
        alert.addTextFieldWithConfigurationHandler { (textField) in
            textField.placeholder = "Input description"
        }
        alert.addTextFieldWithConfigurationHandler { (textField) in
            textField.placeholder = "Input latitude"
        }
        alert.addTextFieldWithConfigurationHandler { (textField) in
            textField.placeholder = "Input longitude"
        }
        let okAction = UIAlertAction(title: "Ok", style: .Default, handler: { (action) in
            let coordinate = Coordinate()
            if let name = alert.TextFields[0].text {
                coordinate.name = name
            }
            if let description = alert.TextFields[1].text {
                coordinate.coordDescription = description
            }
            if let latitude = Double(alert.TextFields[2].text!) {
                coordinate.latitude = latitude
            } else {
                self.output.coordinateInputError(InputErrors.latitude)
                return
            }
            if let longitude = Double(alert.TextFields[3].text!) {
                coordinate.longitude = longitude
            } else {
                self.output.coordinateInputError(InputErrors.longitude)
                return
            }
            self.output.saveCoordinate(coordinate)
        })
        alert.addButton(okAction)
        alert.addButton(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        self.presentViewController(alert.buildAlertController(), animated: true, completion: nil)
    }
    
    func showInputErrorDialog(name: String, description: String) {
        self.showDialogWithMainText(name, secondaryText: description)
    }
    
}

// MARK: - Module Input
extension MainTableViewController: ModuleInputProvider {
	var moduleInput: ModuleInput! {
		return output as? MainTableModuleInput
	}
}
