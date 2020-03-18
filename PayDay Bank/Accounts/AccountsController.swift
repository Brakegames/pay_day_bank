//
//  AccountsController.swift
//  PayDay Bank
//
//  Created by admin on 18.03.2020.
//  Copyright © 2020 Tecman. All rights reserved.
//

import UIKit

class AccountsController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var accountsTable: UITableView!
    
    let apiManager = APIManager.shared
    
    var customerId = 0
    
    var tableData:[[String:Any?]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        accountsTable.delegate = self
        accountsTable.dataSource = self
        accountsTable.tableFooterView = UIView()
        
        apiManager.getAccounts(handler: onAccountsLoad)
    }
    
    private func onAccountsLoad(data:Any?) {
    
        DispatchQueue.main.sync {
            if let data = data as? [[String:Any]] {
                for item in data {
                    if (item["customer_id"] as? Int) == self.customerId {
                        self.tableData.append(item)
                    }
                }
                DispatchQueue.main.async {
                    self.accountsTable.reloadData()
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let info = tableData[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "accountCell") as! AccountCell
        cell.accountNumber.text = info["iban"] as? String
        return cell
    }

}
