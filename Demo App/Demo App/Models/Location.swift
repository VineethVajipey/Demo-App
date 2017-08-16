//
//  Location.swift
//  Demo App
//
//  Created by Vineeth on 8/8/17.
//  Copyright © 2017 Vineeth. All rights reserved.
//

import Foundation

class Location: NSObject {
    
    //PROPERTIES
    var street: String
    var city: String
    var zipCode: String
    var approxAddress: String
    
    //INIT
    init (street: String, city: String, zipCode: String, address: String){
        self.street = street
        self.city = city
        self.zipCode = zipCode
        self.approxAddress = address
        
        super.init()
    }
    
    var dictValue: [String : Any] {
        return ["street" : self.street,
                "city" : self.city,
                "zipCode" : self.zipCode,
            "address" : self.approxAddress]
    }

    
}
