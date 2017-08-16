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

var depType = "Paper"
var depLocation: Location?
var approxAddress: String?

class MainViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate, CLLocationManagerDelegate{
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var typePicker: UIPickerView!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    
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
        
        //PRINT LOCATION ON SOME RANDOM LABEL
        //locationLabel.text = CoordinateToAddressService.approxAddress
        
        
        depLocation = CoordinateToAddressService.depLocation
        
       // print("user latitude = \(userLocation.coordinate.latitude)")
        //print("user longitude = \(userLocation.coordinate.longitude)")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Error \(error)")
    }
    
    
    
    //LKJDLFLSJFLSDJLFJSDKLFJLKSDJFKLJDSL?F

    var typeOptions = ["Paper", "Cardboard", "Metal", "Plastic: PP", "Plastic: HDPE", "Plastic: LDPE", "Plastic: Mixed", "Plastic: LVFM", "Mixed Dry Waste"]
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
         self.hideKeyboardWhenTappedAround() 
        
        //textFields
        self.weightTextField.delegate = self
        self.nameTextField.delegate = self
        self.priceTextField.delegate = self
        
        //typePicker
        typePicker.dataSource = self
        typePicker.delegate = self
        
        backButton.layer.cornerRadius = 24
        typePicker.layer.cornerRadius = 5
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
                    return typeOptions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        //print(pickerView.tag)
            return typeOptions[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        depType = typeOptions[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel = view as? UILabel;
        
        if (pickerLabel == nil)
        {
            pickerLabel = UILabel()
            
            pickerLabel?.font = UIFont(name: "Avenir", size: 17)
            pickerLabel?.textAlignment = NSTextAlignment.center
        }
        
        pickerLabel?.text = fetchLabelForRowNumber(row: row)
        
        return pickerLabel!;
    }
  
    func fetchLabelForRowNumber(row: Int) -> String{
        return typeOptions[row]
    }
    
    @IBAction func submitButtonTapped(_ sender: UIButton) {
        
        let depName = nameTextField.text
        let depWeight = weightTextField.text
        let unitPrice = priceTextField.text
        
        //let userRef = Database.database().reference().child("deposits").childByAutoId()
        //pickerView(pickerView: locationPicker, didSelectRow: 0, inComponent: 0)
        
        DepositService.create(name: depName!, location: depLocation!, weight: depWeight!, type: depType, price: unitPrice!){ (key) in
            
        //DepositListService.create(firUser: firUser!, depRef: key)
            
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

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}


