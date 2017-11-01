//
//  CoinDetailsController.swift
//  coins
//
//  Created by Jeff on 11/1/17.
//  Copyright © 2017 Jeff. All rights reserved.
//

import UIKit

class CoinDetailsController: UIViewController {
    
    private(set) public var coinDetail: CoinDetail!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func initCoinDetail(coin: CoinHolding) {
        coinDetail = DataService.instance.getCoinDetail(forCoinSymbol: coin.coinSymbol)
    }

}
