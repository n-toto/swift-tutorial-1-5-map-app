//
//  ViewController.swift
//  MyMap
//
//  Created by 富木菜穂 on 2021/12/31.
//

import UIKit
import MapKit

class ViewController: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        inputText.delegate = self
    }

    @IBOutlet weak var inputText: UITextField!
    
    @IBOutlet weak var dispMap: MKMapView!
    
    @IBAction func changeMapButton(_ sender: Any) {
        switch dispMap.mapType {
        case .standard:
            dispMap.mapType = .satellite
        case .satellite:
            dispMap.mapType = .hybrid
        case .hybrid:
            dispMap.mapType = .satelliteFlyover
        case .satelliteFlyover:
            dispMap.mapType = .hybridFlyover
        case .hybridFlyover:
            dispMap.mapType = .mutedStandard
        default:
            dispMap.mapType = .standard
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // キーボードを閉じる
        textField.resignFirstResponder()
        
        if let searchKey = textField.text {
            print(searchKey)
            
            let geocoder = CLGeocoder()
            
            geocoder.geocodeAddressString(searchKey, completionHandler: {
                (placemarks, error) in
                
                if let unwrapPlacemarks = placemarks {
                    if let firstPlacemark = unwrapPlacemarks.first {
                        if let location = firstPlacemark.location {
                            let targetCoordinate = location.coordinate
                            print(targetCoordinate)
                            
                            let pin = MKPointAnnotation()
                            
                            pin.coordinate = targetCoordinate
                            pin.title = searchKey
                            
                            self.dispMap.addAnnotation(pin)
                            
                            self.dispMap.region = MKCoordinateRegion(center: targetCoordinate, latitudinalMeters: 500.0, longitudinalMeters: 500.0)
                        }
                    }
                }
            })
            
        }
        return true
    }
}

