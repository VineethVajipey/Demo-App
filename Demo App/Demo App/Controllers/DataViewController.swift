//
//  DataViewController.swift
//  Demo App
//
//  Created by Vineeth on 8/7/17.
//  Copyright © 2017 Vineeth. All rights reserved.
//

import UIKit
import FirebaseDatabase


class DataViewController: UIViewController{
   
    @IBOutlet weak var tableView: UITableView!
    
    //PROPERTIES
    var deposits = [Deposit]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UserService.deposits(for: User.current) { (deposits) in
            self.deposits = deposits
            self.tableView.reloadData()
        }
        super.viewDidLoad()
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
   

}

// MARK: - UITableViewDataSource

extension DataViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return deposits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DepositCell", for: indexPath)
        cell.backgroundColor = .red
        
        return cell
    }
}

