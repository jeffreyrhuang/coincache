//
//  CoinDetailsController.swift
//  coins
//
//  Created by Jeff on 11/1/17.
//  Copyright © 2017 Jeff. All rights reserved.
//

import UIKit

class CoinDetailsController: UIViewController {
    
    let CHART_API = "https://min-api.cryptocompare.com/data/histoday?fsym=BTC&tsym=USD&e=CCCAGG"
    
    var selectedCoin: Coin?

    @IBOutlet weak var coinName: UILabel!
    @IBOutlet weak var availableSupplyData: UILabel!
    @IBOutlet weak var marketCapData: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        coinName.text = selectedCoin?.name
        availableSupplyData.text = selectedCoin?.available_supply
        marketCapData.text = selectedCoin?.market_cap_usd
        
        getChartData(url: CHART_API, parameters: nil)
    }

    // MARK: Networking
    func getChartData(url: String, parameters: [String:String]?) {
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
//    func initCoinDetail(coin: CoinHolding) {
//        selectedCoin = DataService.instance.getCoinDetail(forCoinSymbol: coin.coinSymbol)
//
//        navigationItem.title = coin.name
//    }

}
