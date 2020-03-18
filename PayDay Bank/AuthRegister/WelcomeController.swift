//
//  WelcomeController.swift
//  PayDay Bank
//
//  Created by admin on 18.03.2020.
//  Copyright © 2020 Tecman. All rights reserved.
//

import UIKit

class WelcomeController: UIViewController {

    @IBOutlet weak var welcomeLabel: UILabel!
    
    var firstName = ""
    var lastName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        welcomeLabel.text = "Welcome, \(firstName) \(lastName)!"
    }

}
