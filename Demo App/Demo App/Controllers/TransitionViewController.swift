//
//  TransitionViewController.swift
//  Demo App
//
//  Created by Vineeth on 8/8/17.
//  Copyright © 2017 Vineeth. All rights reserved.
//

import UIKit

class TransitionViewController: UIViewController {

    
    @IBOutlet weak var addDepositButton: UIButton!
    @IBOutlet weak var viewGraphsButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func addDepositButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "navToDeposit", sender:UIButton.self)
    }
    
    @IBAction func viewGraphsButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "navToData", sender: UIButton.self)
    }
    
    
}
