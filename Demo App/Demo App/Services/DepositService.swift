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
    
    static func create( name: String, location: Location, weight: String, type: String, price: String, completion: @escaping(String) -> Void) {
        
        
        let userAttrs = ["name": name, "weight": weight, "type": type, "date": dateToString(yourDate: Date()), "time": timeToString(yourDate: Date()), "unitPrice": price] as [String : Any]
        
        let ref = Database.database().reference().child("users").child(User.current.uid).child("deposits").childByAutoId()
        ref.updateChildValues(userAttrs) { (error, ref)  in
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
    
    static func show(forKey depKey: String, posterUID: String, completion: @escaping (Deposit?) -> Void) {
        
        let ref = Database.database().reference().child("users").child(User.current.uid).child("deposits").child(depKey)
        
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            //guard let deposit = Deposit(snapshot: snapshot) else {
            guard let deposit = Deposit(snapshot: snapshot) else {
                return completion(nil)
            }
            completion(deposit)
        })
    }
    
    
    
}
