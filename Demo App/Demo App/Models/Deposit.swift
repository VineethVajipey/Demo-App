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
    var creationDate: Date
    
    // MARK: - Init
    
    init (name: String, location: Location, weight: String, type: String){
        
        self.name = name
        self.location = location
        self.weight = weight
        self.type = type
        self.creationDate = Date()
        super.init()
    }
    
    init?(snapshot: DataSnapshot) {
        guard let dict = snapshot.value as? [String : Any],
            let name = dict["name"] as? String,
            let weight = dict["weight"] as? String,
            let type = dict["type"] as? String,
            let time = dict["time"] as? TimeInterval,
            let location = dict["location"] as? Location
            else { return nil }
        
        self.key = snapshot.key
        self.name = name
        self.weight = weight
        self.type = type
        self.creationDate = Date(timeIntervalSince1970: time)
        self.location = location
    }
}
