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
    var customerId = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        welcomeLabel.text = "Welcome, \(firstName) \(lastName)!"
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let controller = self.storyboard?.instantiateViewController(identifier: "accountsView") as! AccountsController
            controller.customerId = self.customerId
            self.present(controller, animated: true)
        }
    }

}
