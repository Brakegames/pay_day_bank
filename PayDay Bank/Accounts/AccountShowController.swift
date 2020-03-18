//
//  AccountShowController.swift
//  PayDay Bank
//
//  Created by admin on 18.03.2020.
//  Copyright © 2020 Tecman. All rights reserved.
//

import UIKit

class AccountShowController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var creationLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var transactionsTable: UITableView!
    
    let apiManager = APIManager.shared
    
    var tableData:[[String:Any?]] = []
    
    var accountId = 0
    var accountNumber = ""
    var creationDate = ""
    var accountType = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        numberLabel.text = accountNumber
        creationLabel.text = "Creation date: \(creationDate)"
        typeLabel.text = "Type: \(accountType)"
        
        transactionsTable.delegate = self
        transactionsTable.dataSource = self
        
        apiManager.getTransaction(handler: onTransactionsLoad)
    }
    
    private func onTransactionsLoad(data:Any?) {
    
        DispatchQueue.main.sync {
            if let data = data as? [[String:Any]] {
                for item in data {
                    if (item["account_id"] as? Int) == self.accountId {
                        self.tableData.append(item)
                    }
                }
                DispatchQueue.main.async {
                    self.transactionsTable.reloadData()
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let info = tableData[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "transactionCell") as! TransactionCell
        cell.vendorLabel.text = "Vendor: \(info["vendor"] as! String)"
        cell.categoryLabel.text = "Category: \(info["category"] as! String)"
        cell.dateLabel.text = "Date: \(info["date"] as! String)"
        cell.amountLabel.text = "Amount: \(info["amount"] as! String)"
        return cell
    }

    @IBAction func onBackButton() {
        self.dismiss(animated: true, completion: nil)
    }
    
}
