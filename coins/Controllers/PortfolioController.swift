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
    lazy var ownedCoins: Results<Coin> = { self.realm.objects(Coin.self).filter("owned = true") }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // For Realm browser
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        coinHoldingTable.dataSource = self
        coinHoldingTable.delegate = self
        
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
                            realm.add(coin, update: true)
                        }
                    }
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
        let selectedCoin = ownedCoins[indexPath.row]
        performSegue(withIdentifier: "CoinDetailsController", sender: self)
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
            
            coinDetailsController.selectedCoin = sender as? Coin
        }
    }


}

