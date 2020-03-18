//
//  AuthorizeController.swift
//  PayDay Bank
//
//  Created by admin on 18.03.2020.
//  Copyright © 2020 Tecman. All rights reserved.
//

import UIKit

class AuthorizeController: UIViewController {

    let apiManager = APIManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func onLoginButton() {
        apiManager.authorize(login: "Nadiah.Spoel@example.com", password: "springs", handler: onLoginResponse)
    }
    
    private func onLoginResponse(data:Any?) {
        
        DispatchQueue.main.sync {
            if let data = data as? [String:Any] {
                print("success")
            } else if let data = data as? [[String:Any]] {
                let message = data[0]["message"] as! String
                let alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ок", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
        }
    }
}
