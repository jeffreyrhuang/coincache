//
//  FirstViewController.swift
//  coins
//
//  Created by Jeff on 10/25/17.
//  Copyright © 2017 Jeff. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import ObjectMapper
import RealmSwift

class PortfolioController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let TICKER_API = "https://api.coinmarketcap.com/v1/ticker/"

    @IBOutlet weak var coinHoldingTable: UITableView!
    @IBOutlet weak var totalValueLabel: UILabel!
    
    let realm = try! Realm()
    lazy var ownedCoins: Results<Coin> = { self.realm.objects(Coin.self).filter("isOwned = true") }()
    var totalValue: Double = 0.0
    
    private let refreshControl = UIRefreshControl()
    
    override func viewDidAppear(_ animated: Bool) {
        let coins = Array(ownedCoins)
        totalValue = coins.reduce(0.0) { $0 + ($1.amount * $1.price_usd) }
        totalValueLabel.text = "$" + String(format: "%.2f", totalValue)
        
        self.coinHoldingTable.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // For Realm browser
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        coinHoldingTable.dataSource = self
        coinHoldingTable.delegate = self
        
        if #available(iOS 10.0, *) {
            coinHoldingTable.refreshControl = refreshControl
        } else {
            coinHoldingTable.addSubview(refreshControl)
        }
        refreshControl.addTarget(self, action: #selector(refreshTickerData(_:)), for: .valueChanged)
        
        getTickerData(url: TICKER_API, parameters: nil)

    }
    
    @objc private func refreshTickerData(_ sender: Any) {
        getTickerData(url: TICKER_API, parameters: nil)
    }
    
    // MARK: Networking
    
    func getTickerData(url: String, parameters: [String:String]?) {
        
        Alamofire.request(url, method: .get).responseArray { (response: DataResponse<[Coin]>) in
            if response.result.isSuccess {
                
                print("Successful call to API")
                let coinArray = response.result.value
                do {
                    let realm = try Realm()
                    try realm.write {
                        for coin in coinArray! {
                            if let currentCoin = realm.object(ofType: Coin.self, forPrimaryKey: coin.id) {
                                coin.isOwned = currentCoin.isOwned
                                coin.isWatched = currentCoin.isWatched
                                coin.amount = currentCoin.amount
                            }
                            realm.add(coin, update: true)
                        }
                    }
                self.refreshControl.endRefreshing()
                
                } catch let error as NSError {
                    print(error.localizedDescription)
                }
                
            
            } else {
                print("Connection Issues")
            }
        }
    }
    
    // MARK: Table functions
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CoinHoldingCell") as? CoinHoldingCell {
            let coin = ownedCoins[indexPath.row]
            cell.updateViews(ownedCoin: coin)
            return cell
        } else {
            return CoinHoldingCell()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ownedCoins.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "CoinDetailsController", sender: self)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let deletedCoin = ownedCoins[indexPath.row]
            if let coin =  realm.object(ofType: Coin.self, forPrimaryKey: deletedCoin.id) {
                try! realm.write {
                    coin.isOwned = false
                    coin.amount = 0.0
                }
            }
            
            coinHoldingTable.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: Segues
    
    @IBAction func cancelAddCoin(unwindSegue: UIStoryboardSegue) {
        
    }
    
    @IBAction func unwindToPortfolio(segue: UIStoryboardSegue) {
        self.coinHoldingTable.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CoinDetailsController" {
            let coinDetailsController = segue.destination as! CoinDetailsController
            // to change back bar title for next view
            let barBtn = UIBarButtonItem()
            barBtn.title = ""
            navigationItem.backBarButtonItem = barBtn
            let indexPath = coinHoldingTable.indexPathForSelectedRow!
            let selectedCoin = ownedCoins[indexPath.row]
            coinDetailsController.selectedCoin = selectedCoin
        }
    }


}

