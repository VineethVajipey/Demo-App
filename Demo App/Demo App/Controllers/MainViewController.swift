//
//  ViewController.swift
//  Demo App
//
//  Created by Vineeth on 7/24/17.
//  Copyright © 2017 Vineeth. All rights reserved.
//

import UIKit
import Foundation
import Firebase
import FirebaseDatabase
import CoreLocation

var depType = "Type 1"
var depLocation: Location?

class MainViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate, CLLocationManagerDelegate{
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var typePicker: UIPickerView!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var locationPicker: UIPickerView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var locationLabel: UILabel!
    
    
    //CORELOCATIONJSLJDLJAKDJLKAJkadSDKFFDF
    
    var locationManager:CLLocationManager!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        determineMyCurrentLocation()
    }
    
    func determineMyCurrentLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
            //locationManager.startUpdatingHeading()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation
        
        // Call stopUpdatingLocation() to stop listening for location updates,
        // other wise this function will be called every time when user location changes.
        
        // manager.stopUpdatingLocation()
        
        CoordinateToAddressService.getAddressFromGeocodeCoordinate(coordinate: userLocation.coordinate)
    
        
        //(street: CoordinateToAddressService.addStreet , city: CoordinateToAddressService.addCity, zipCode:CoordinateToAddressService.addZip)
        
        locationLabel.text = CoordinateToAddressService.approxAddress
        
        depLocation = CoordinateToAddressService.depLocation
        
       // print("user latitude = \(userLocation.coordinate.latitude)")
        //print("user longitude = \(userLocation.coordinate.longitude)")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Error \(error)")
    }
    
    
    
    //LKJDLFLSJFLSDJLFJSDKLFJLKSDJFKLJDSL?F
    
    var locationOptions = ["Area 1", "Area 2", "Area 3", "Area 4"]
    var typeOptions = ["Type 1", "Type 2", "Type 3", "Type 4"]
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //textFields
        self.weightTextField.delegate = self;
        self.nameTextField.delegate = self;
        
        //locationPikcer
        locationPicker.dataSource = self
        locationPicker.delegate = self
        
        //typePicker
        typePicker.dataSource = self
        typePicker.delegate = self
    }
    
    //UIPICKER FUNCTIONS
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        
//    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
                //print(pickerView.tag)
                if pickerView.tag == 0 {
                    return locationOptions.count
                }
                else if pickerView.tag == 1{
                    return typeOptions.count
                }
                else {
                    return 0
                }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        //print(pickerView.tag)
        if pickerView.tag == 0 {
            return locationOptions[row]
        }
        else {
            return typeOptions[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        
        
            if(row == 0)
            {
                depType = "Type 0"
            }
            else if(row == 1)
            {
                depType = "Type 1"
            }
            else if(row == 2)
            {
                depType = "Type 2"
            }
            else
            {
                depType = "Type 3"
            }
        
    }
  
    
    @IBAction func submitButtonTapped(_ sender: UIButton) {
        
        let depName = nameTextField.text
        //let date = ServerValue.timestamp()
        let depWeight = weightTextField.text
        
        //let userRef = Database.database().reference().child("deposits").childByAutoId()
        //pickerView(pickerView: locationPicker, didSelectRow: 0, inComponent: 0)
        
        DepositService.create(name: depName!, location: depLocation!, weight: depWeight!, type: depType){ (key) in
            
        let firUser = Auth.auth().currentUser        
        DepositListService.create(firUser: firUser!, depRef: key)
            
        }
    }
}

/*
 GET TIMESTAMP BACK INTO CODE
 let ref = Firebase(url: "<FIREBASE HERE>")
 
 // Tell the server to set the current timestamp at this location.
 ref.setValue(ServerValue.timestamp())
 
 // Read the value at the given location. It will now have the time.
 ref.observeEventType(.Value, withBlock: {
 snap in
 if let t = snap.value as? NSTimeInterval {
 // Cast the value to an NSTimeInterval
 // and divide by 1000 to get seconds.
 println(NSDate(timeIntervalSince1970: t/1000))
 }
 })
 */

