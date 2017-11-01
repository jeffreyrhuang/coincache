//
//  FirstViewController.swift
//  coins
//
//  Created by Jeff on 10/25/17.
//  Copyright © 2017 Jeff. All rights reserved.
//

import UIKit

class PortfolioController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var coinHoldingTable: UITableView!
    @IBOutlet weak var totalLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        coinHoldingTable.dataSource = self
        coinHoldingTable.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CoinHoldingCell") as? CoinHoldingCell {
            let coinHolding = DataService.instance.getCoinHoldings()[indexPath.row]
            cell.updateViews(coinHolding: coinHolding)
            return cell
        } else {
            return CoinHoldingCell()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataService.instance.getCoinHoldings().count
    }


}

