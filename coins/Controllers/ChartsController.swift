//
//  SecondViewController.swift
//  coins
//
//  Created by Jeff on 10/25/17.
//  Copyright © 2017 Jeff. All rights reserved.
//

import UIKit
import Charts
import RealmSwift

class ChartsController: UIViewController {

    let realm = try! Realm()
    lazy var ownedCoins: Results<Coin> = { self.realm.objects(Coin.self).filter("owned = true") }()

    @IBOutlet weak var pieChart: PieChartView!
    
    override func viewDidAppear(_ animated: Bool) {
        print("view appearing")
        setChart()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("view loading")
        
    }
    
    func setChart() {
        var dataEntries: [PieChartDataEntry] = []
        let coins = Array(ownedCoins)
        print(coins)
        
        let totalValue = coins.reduce(0.0) { $0 + ($1.amount * $1.price_btc) }
        print(totalValue)
        
        for coin in coins {
            let percentage = coin.value / totalValue * 100
            dataEntries.append(PieChartDataEntry(value: percentage, label: coin.symbol))
        }

        let dataSet = PieChartDataSet(values: dataEntries, label: "")
        let data = PieChartData(dataSet: dataSet)
        
        var colors: [UIColor] = []
        
        for _ in 0..<dataEntries.count {
            let red = Double(arc4random_uniform(256))
            let green = Double(arc4random_uniform(256))
            let blue = Double(arc4random_uniform(256))
            
            let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
            colors.append(color)
        }
        dataSet.colors = colors
        dataSet.entryLabelColor = .black
        dataSet.xValuePosition = .outsideSlice
        dataSet.drawValuesEnabled = false
        
        pieChart.centerText = "Portfolio"
        pieChart.noDataText = "No data available"
        pieChart.transparentCircleColor = UIColor.clear
        pieChart.chartDescription?.enabled = false
        pieChart.data = data
        pieChart.legend.enabled = false
 
        
    }


}

