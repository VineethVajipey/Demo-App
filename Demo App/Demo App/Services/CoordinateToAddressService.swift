  //
//  CoordinateToAddressService.swift
//  Demo App
//
//  Created by Vineeth on 8/7/17.
//  Copyright © 2017 Vineeth. All rights reserved.
//

import Foundation
import CoreLocation

struct CoordinateToAddressService {
    
    static var approxAddress: String?
    static var depLocation: Location?
    
static func getAddressFromGeocodeCoordinate(coordinate: CLLocationCoordinate2D) {
    let geoCoder = CLGeocoder()
    let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
    geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
        
        // Place details
        var placeMark: CLPlacemark!
        placeMark = placemarks?[0]
        
        //var addLocationName : NSString
        var addStreet : String = ""
        var addCity : String = ""
        var addZip : String = ""
        //var addCountry : NSString
        
        // Location name
        //if let locationName = placeMark.addressDictionary!["Name"] as? NSString {
        //addLocationName = locationName
        //}
        // Street address
        if let street = placeMark.addressDictionary!["Thoroughfare"] as? String {
             addStreet = street
        }
        // City
        if let city = placeMark.addressDictionary!["City"] as? String {
             addCity = city
        }
        // Zip code
        if let zip = placeMark.addressDictionary!["ZIP"] as? String {
             addZip = zip
        }
        // Country
        //if let country = placeMark.addressDictionary!["Country"] as? NSString {
        //    addCountry = country
        //}
        
        approxAddress = "\(addStreet), \(addCity), \(addZip)"
        let tempLoc = Location(street: addStreet, city: addCity, zipCode: addZip, address: approxAddress!)
        depLocation = tempLoc
        
    })
    
}
}
