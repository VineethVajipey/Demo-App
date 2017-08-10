//
//  DepositService.swift
//  Demo App
//
//  Created by Vineeth on 8/1/17.
//  Copyright © 2017 Vineeth. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseCore
import FirebaseAuth.FIRUser

struct DepositService{
    
    static func create( name: String, location: Location, weight: String, type: String, completion: @escaping(String) -> Void) {
        
        let userAttrs = ["name": name, "weight": weight, "type": type, "time": ServerValue.timestamp()] as [String : Any]
        
        let ref = Database.database().reference().child("deposits").childByAutoId()
        ref.setValue(userAttrs) { (error, ref)  in
            if let error = error {
                assertionFailure(error.localizedDescription)
            }
        }
        
        let locref = ref.child("location")
        locref.setValue(location.dictValue) { (error, locref) in
            if let error = error {
                assertionFailure(error.localizedDescription)
                return completion(ref.key)
            }
        }
        return completion(ref.key)
    }
    
 
    
}
