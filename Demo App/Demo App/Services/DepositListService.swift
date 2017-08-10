//
//  DepositListService.swift
//  Demo App
//
//  Created by Vineeth on 8/9/17.
//  Copyright © 2017 Vineeth. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct DepositListService {
    
    
    
    static func create(firUser: FIRUser, depRef: String){
        
        let ref = Database.database().reference().child("depositlist").child(firUser.uid).childByAutoId()
            ref.setValue(depRef) { (error, ref)  in
            if let error = error {
                assertionFailure(error.localizedDescription)
            }
        }
        //let ref2 = Database.database().reference().child("users").child(firUser.uid)
          //  ref2.setValue(ref.key)
        
    }
}
