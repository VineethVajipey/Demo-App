//
//  DepositList.swift
//  Demo App
//
//  Created by Vineeth on 8/9/17.
//  Copyright © 2017 Vineeth. All rights reserved.
//

import Foundation
import FirebaseDatabase

class DepositList: NSObject {
    
    //PROPERTIES
    var userDeposits: [DatabaseReference]
    
    //INIT
    init (userDeposits: [DatabaseReference]){
        self.userDeposits = userDeposits
    }
}
