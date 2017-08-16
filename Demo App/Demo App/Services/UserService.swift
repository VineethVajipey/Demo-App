//
//  UserService.swift
//  Demo App
//
//  Created by Vineeth on 7/31/17.
//  Copyright © 2017 Vineeth. All rights reserved.
//

import Foundation
import FirebaseAuth.FIRUser
import FirebaseDatabase

struct UserService {
    
    static func create(_ firUser: FIRUser, username: String, completion: @escaping (User?) -> Void) {
        let userAttrs = ["username": username]
        
        let ref = Database.database().reference().child("users").child(firUser.uid)
        ref.setValue(userAttrs) { (error, ref) in
            if let error = error {
                assertionFailure(error.localizedDescription)
                return completion(nil)
            }
            
            ref.observeSingleEvent(of: .value, with: { (snapshot) in
                let user = User(snapshot: snapshot)
                completion(user)
            })
        }
    }
    
    static func deposits(for user: User, completion: @escaping ([Deposit]) -> Void) {
        let ref = Database.database().reference().child("depositlist").child(user.uid)
        
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let snapshot = snapshot.children.allObjects as? [DataSnapshot] else {
                return completion([])
            }
            
            let deposits = snapshot.reversed().flatMap(Deposit.init)
            completion(deposits)
        })
    }
    
    static func timeline(completion: @escaping ([Deposit]) -> Void) {
        let currentUser = User.current
        
        //get ref to timeline -> current user
        
        let timelineRef = Database.database().reference().child("users").child(currentUser.uid).child("deposits")
        //observe that timeline
        //then save all the objects under the snapshot to an array of Datasnapshots
        
        timelineRef.observeSingleEvent(of: .value, with: { (snapshot) in
            
            guard let snapshot = snapshot.children.allObjects as? [DataSnapshot]
                else {
                    print("error")
                    return completion([])
            }
            //create an empty array of deposits, to hold all the deposits
            var alldeps = [Deposit]()
            
            //snapshot is an array of datasnapshots, and we cycle through all of them., each snapshot is a deposit.
            //for loop through the snapshot
            for depositSnap in snapshot {
                alldeps.append(Deposit(snapshot: depositSnap)!)

            }
            completion(alldeps.reversed())
        
        
            //        dispatchGroup.notify(queue: .main, execute: {
            //            completion(alldeps.reversed())
            //        })
        })
    }
    
}

//            // cerate a dispatch group?
//            let dispatchGroup = DispatchGroup()



//check and set "postDict" to the .value of the data snapshot, into a dictionary?
//            guard let depositDict = depositSnap.value as? [String : Any],
//                let posterUID = depositDict["poster_uid"] as? String
//
//                else { continue }
//
//            dispatchGroup.enter()
//
//            DepositService.show(forKey: depositSnap.key, posterUID: posterUID) { (deposit) in
//                if let deposit = deposit {
//                    alldeps.append(deposit)
//
//                }
//
//                dispatchGroup.leave()
//            }
