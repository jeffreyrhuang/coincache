//
//  CoinDetailsController.swift
//  coins
//
//  Created by Jeff on 11/1/17.
//  Copyright © 2017 Jeff. All rights reserved.
//

import UIKit
import Charts
import Alamofire
import SwiftyJSON

class CoinDetailsController: UIViewController {
    
    let CHART_API = "https://min-api.cryptocompare.com/data/histoday?tsym=USD&e=CCCAGG"
    
    var selectedCoin: Coin?
    var dataEntries: [ChartDataEntry] = []

    @IBOutlet weak var coinName: UILabel!
    @IBOutlet weak var availableSupplyData: UILabel!
    @IBOutlet weak var marketCapData: UILabel!
    @IBOutlet weak var lineChart: LineChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        coinName.text = selectedCoin?.name
        availableSupplyData.text = selectedCoin?.available_supply
        marketCapData.text = selectedCoin?.market_cap_usd
        let fromCoin:String = (selectedCoin?.symbol)!
        getChartData(url: CHART_API, parameters: ["fsym": fromCoin])
        
    }
    

    // MARK: Networking
    func getChartData(url: String, parameters: [String:String]?) {
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON {
            response in
            if response.result.isSuccess {
                print("Successful call to Chart API")
                let data: JSON = JSON(response.result.value!)["Data"]
                print(response)
                print(data)
                self.updateChartData(jsonData: data)
            } else {
                print("Connection Issues")
            }
            
            
        }
    }
    
    func updateChartData(jsonData: JSON) {
        for i in 0..<jsonData.count {
            let price = jsonData[i]["high"].double!
            let time = jsonData[i]["time"].double!
            let dataPoint = ChartDataEntry(x: time, y: price)
            dataEntries.append(dataPoint)
            print("now for the data entries")
            print(dataEntries)
            let dataSet = LineChartDataSet(values: dataEntries, label: "\((selectedCoin?.name)!)")
            let data = LineChartData()
            data.addDataSet(dataSet)
            data.setDrawValues(false)
            
            dataSet.colors = [NSUIColor.blue]
            dataSet.circleRadius = 0.0
            
            lineChart.xAxis.labelPosition = .bottom
            lineChart.xAxis.drawGridLinesEnabled = false
            lineChart.data = data
            lineChart.rightAxis.enabled = false
        }
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
