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

class ChartsController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let realm = try! Realm()
    var ownedCoins: Results<Coin>?
    var coins: [Coin] = []
    
    @IBOutlet weak var pieChart: PieChartView!
    @IBOutlet weak var chartTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.ownedCoins = self.realm.objects(Coin.self).filter("owned = true")
        coins = Array(ownedCoins!)
    
        chartTable.dataSource = self
        chartTable.delegate = self
        
        setChart()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        coins = Array(ownedCoins!)
        setChart()
        self.chartTable.reloadData()
    }
    
    func setChart() {
        var dataEntries: [PieChartDataEntry] = []
        
        let totalValue = coins.reduce(0.0) { $0 + ($1.amount * $1.price_usd) }
        
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
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ChartCoinCell") as? ChartCoinCell {
            let coin = coins[indexPath.row]
            let totalValue = coins.reduce(0.0) { $0 + ($1.amount * $1.price_usd) }
            cell.name.text = coin.name
            cell.percentage.text = "\(coin.value / totalValue * 100) %"
            return cell
            
        } else {
            return ChartCoinCell()
        }
    }


}

