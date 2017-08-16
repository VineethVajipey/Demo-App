//
//  Deposit.swift
//  Demo App
//
//  Created by Vineeth on 7/31/17.
//  Copyright © 2017 Vineeth. All rights reserved.
//

import Foundation
import FirebaseDatabase

class Deposit: NSObject{
  
    // MARK: - Properties
    let name: String
    let weight: String
    let location: Location
    let type: String
    var key: String?
    var creationDate: String
    var creationTime: String
    let unitPrice: String
    
    // MARK: - Init
    
    init (name: String, location: Location, weight: String, type: String, price: String){
        
        self.name = name
        self.unitPrice = price
        self.location = location
        self.weight = weight
        self.type = type
        self.creationDate = ""
        self.creationTime = ""
        super.init()
    }
    
    init?(snapshot: DataSnapshot) {
        guard let dict = snapshot.value as? [String : Any],
            let name = dict["name"] as? String,
            let weight = dict["weight"] as? String,
            let type = dict["type"] as? String,
            let date = dict["date"] as? String,
            let time = dict["time"] as? String,
            let locationDict = dict["location"] as? [String: String],
            let price = dict["unitPrice"] as? String
        
        
            else { return nil }
        let location = Location(street: locationDict["street"]!, city: locationDict["city"]!, zipCode: locationDict["zipCode"]!, address: locationDict["address"]!)
        self.key = snapshot.key
        self.name = name
        self.weight = weight
        self.type = type
        self.creationDate = date
        self.creationTime = time
        self.location = location
        self.unitPrice = price
    }

    
}
