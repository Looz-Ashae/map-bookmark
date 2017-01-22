//
//  MapMBMapViewController.swift
//  map-bookmark
//
//  Created by rizer on 18/01/2017.
//  Copyright © 2017 com.rizer. All rights reserved.
//

import UIKit
import Mapbox

class MapViewController: BaseViewController {
    weak var assembler = ViperAssembler<MapModuleAssembly>()

    @IBOutlet weak var viewMap: MGLMapView!
    var output: MapViewOutput!

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBarHidden = false
    }
    
    private func centerMapWithCoordinate(coordinate: Coordinate) -> CLLocationCoordinate2D {
        let curCoordinate = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
        viewMap.setCenterCoordinate(curCoordinate, zoomLevel: 12, animated: false)
        return curCoordinate
    }
}

// MARK: - View Input
extension MapViewController: MapViewInput {
    func setupInitialState() {
        viewMap.delegate = self
        let longTapOnMap = UILongPressGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        
        viewMap.addGestureRecognizer(longTapOnMap)
        longTapOnMap.delegate = self
    }
    
    func showAnnotationAdditionDialog(coordinate: Coordinate) {
        let alert = AlertControllerConstructor(style: .Alert, title: "Give name and description of the bookmark", message: "")
        alert.addTextFieldWithConfigurationHandler { (textField) in
            textField.placeholder = "Input name"
        }
        alert.addTextFieldWithConfigurationHandler { (textField) in
            textField.placeholder = "Input description"
        }
        let okAction = UIAlertAction(title: "Ok", style: .Default, handler: { (action) in
            if let name = alert.TextFields[0].text {
                coordinate.name = name
            }
            if let description = alert.TextFields[1].text {
                coordinate.coordDescription = description
            }
            self.putAnnotationToCoordinate(coordinate)
        })
        alert.addButton(okAction)
        alert.addButton(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        self.presentViewController(alert.buildAlertController(), animated: true, completion: nil)
    }
    
    func setCenterAnnotationWithCoordinate(coordinate: Coordinate) {
        let curCoordinate = centerMapWithCoordinate(coordinate)
        let annotation = MGLPointAnnotation()
        annotation.coordinate = curCoordinate
        annotation.title = coordinate.name
        annotation.subtitle = coordinate.coordDescription
        viewMap.addAnnotation(annotation)
    }
    
    func centerMap(coordinate: Coordinate) {
        self.centerMapWithCoordinate(coordinate)
    }
    
    func putAnnotationToCoordinate(coordinate: Coordinate) {
        let curCoordinate = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
        let annotation = MGLPointAnnotation()
        annotation.coordinate = curCoordinate
        annotation.title = coordinate.name
        annotation.subtitle = coordinate.coordDescription
        viewMap.addAnnotation(annotation)
        output.annotationAdded(coordinate)
    }
}

extension MapViewController: MGLMapViewDelegate {
    func handleTap(recognizer: UILongPressGestureRecognizer) {
        let mapCoordinate = self.viewMap.convertPoint(recognizer.locationInView(recognizer.view), toCoordinateFromView: viewMap)
        let coordinate = Coordinate()
        coordinate.latitude = mapCoordinate.latitude
        coordinate.longitude = mapCoordinate.longitude
        output.mapTappedWithCoordinate(coordinate)
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
}

// MARK: - Module Input
extension MapViewController: ModuleInputProvider {
	var moduleInput: ModuleInput! {
		return output as? MapModuleInput
	}
}
