//
//  AuthorizeController.swift
//  PayDay Bank
//
//  Created by admin on 18.03.2020.
//  Copyright © 2020 Tecman. All rights reserved.
//

import UIKit

class AuthorizeController: UIViewController {

    @IBOutlet weak var emailInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    let apiManager = APIManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signInButton.layer.cornerRadius = 10
    }

    @IBAction func onLoginButton() {
        if emailInput.text?.count == 0 {
            let alert = UIAlertController(title: "E-mail can not be empty", message: "Please fill e-mail", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ок", style: .default, handler: nil))
            self.present(alert, animated: true)
            return
        }
        if passwordInput.text?.count == 0 {
            let alert = UIAlertController(title: "Password can not be empty", message: "Please fill password", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ок", style: .default, handler: nil))
            self.present(alert, animated: true)
            return
        }
        
        let email = emailInput.text!
        let password = passwordInput.text
        
        apiManager.authorize(login: email, password: password!, handler: onLoginResponse)
    }
    
    private func onLoginResponse(data:Any?) {
        
        DispatchQueue.main.sync {
            if let data = data as? [String:Any] {
                if data.count == 0 {
                    let alert = UIAlertController(title: "Error", message: "E-mail and/or password are incorrect", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Ок", style: .default, handler: nil))
                    self.present(alert, animated: true)
                    return
                }
                let firstName = data["First Name"] as? String
                let lastName = data["Last Name"] as? String
                let controller = self.storyboard?.instantiateViewController(identifier: "welcomeView") as! WelcomeController
                controller.firstName = firstName!
                controller.lastName = lastName!
                self.present(controller, animated: true)
            } else {
                let alert = UIAlertController(title: "Error", message: "Something goes wrong", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ок", style: .default, handler: nil))
                self.present(alert, animated: true)
                return
            }
        }
    }
}
