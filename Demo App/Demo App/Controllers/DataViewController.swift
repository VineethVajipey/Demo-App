//
//  DataViewController.swift
//  Demo App
//
//  Created by Vineeth on 8/7/17.
//  Copyright © 2017 Vineeth. All rights reserved.
//

import UIKit
import FirebaseDatabase

var deposits = [Deposit]()
var currentCell: UITableViewCell?

class DataViewController: UIViewController{
   
   @IBOutlet weak var tableView: UITableView!
    @IBAction func unwindToData(segue:UIStoryboardSegue) {}
    //PROPERTIES
    
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        currentCell?.isSelected = false
        
        UserService.timeline { (allDeps) in
            deposits = allDeps
           // print(deposits)
            print("timelineran")
            self.tableView.reloadData()
        }
        
        super.viewDidLoad()
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    
    }
  /*func updateCell(count: Int) {
        nameLabel.text = deposits[count].name
        
        dateLabel.text = dateToString(yourDate: deposits[count].creationDate)
        }
    */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "displayInfo" {
                let indexPath = tableView.indexPathForSelectedRow!
                // 2
                let deposit = deposits[indexPath.row]
                let DisplayDepositViewController = segue.destination as! DisplayDepositViewController
                 DisplayDepositViewController.deposit = deposit
            }
        }
    }
    
}


// MARK: - UITableViewDataSource

extension DataViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(deposits.count)
        return deposits.count
            }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DepositCell", for: indexPath) as! TableViewCell
        
        let deposit = deposits[indexPath.row]
        cell.nameLabel.text = deposit.name
        print("this is the deposit name" + "\(deposit.name)")
       cell.dateLabel.text = deposit.creationDate
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

    }
}

func dateToString(yourDate: Date) -> String{
    let formatter = DateFormatter()
    //then again set the date format whhich type of output you need
    formatter.dateFormat = "MMM d, yyyy"
    // again convert your date to string
    let myStringafd = formatter.string(from: yourDate)
    
    return(myStringafd)
}

func timeToString(yourDate: Date) -> String{
    let formatter = DateFormatter()
    //then again set the date format whhich type of output you need
    formatter.dateFormat = "HH:mm"
    // again convert your date to string
    let myStringafd = formatter.string(from: yourDate)
    
    return(myStringafd)
}

