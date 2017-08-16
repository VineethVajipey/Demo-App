//
//  DisplayDepositViewController.swift
//  Demo App
//
//  Created by Vineeth on 8/14/17.
//  Copyright © 2017 Vineeth. All rights reserved.
//

import UIKit

class DisplayDepositViewController: UIViewController {

    @IBOutlet weak var empNameLabel: UILabel!
    @IBOutlet weak var supNameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var unitPriceLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    
    var deposit: Deposit?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        empNameLabel.text = deposit?.name
        supNameLabel.text = User.current.username
        locationLabel.text = deposit?.location.approxAddress
        dateLabel.text = deposit?.creationDate
        timeLabel.text = deposit?.creationTime
        unitPriceLabel.text = deposit?.unitPrice
        weightLabel.text = deposit?.weight
        typeLabel.text = deposit?.type
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
