//
//  AuthRegisterController.swift
//  PayDay Bank
//
//  Created by admin on 18.03.2020.
//  Copyright © 2020 Tecman. All rights reserved.
//

import UIKit

class AuthRegisterController: UIViewController {

    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signInButton.layer.cornerRadius = 10
        signUpButton.layer.cornerRadius = 10
    }

    @IBAction func onSignInButton() {
        let controller = self.storyboard?.instantiateViewController(identifier: "authView")
        self.present(controller!, animated: true)
    }
    
}
