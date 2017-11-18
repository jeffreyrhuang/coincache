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
    lazy var ownedCoins: Results<Coin> = { self.realm.objects(Coin.self).filter("isOwned = true") }()
    var coins: [Coin] = []
    
    @IBOutlet weak var pieChart: PieChartView!
    @IBOutlet weak var chartTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chartTable.dataSource = self
        chartTable.delegate = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        coins = Array(ownedCoins)
        coins.sort { $0.value > $1.value }
        setChart()
        self.chartTable.reloadData()
        
        print("view appearing")
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
    
        // Prepare colors
        var colors: [UIColor] = []
        let gray = UIColor(red:0.30, green:0.30, blue:0.30, alpha:1.0)
        let blue = UIColor(red:0.36, green:0.65, blue:0.85, alpha:1.0)
        let orange = UIColor(red:0.98, green:0.64, blue:0.23, alpha:1.0)
        let green = UIColor(red:0.38, green:0.74, blue:0.41, alpha:1.0)
        let pink = UIColor(red:0.95, green:0.49, blue:0.69, alpha:1.0)
        let brown = UIColor(red:0.70, green:0.57, blue:0.18, alpha:1.0)
        let purple = UIColor(red:0.70, green:0.46, blue:0.70, alpha:1.0)
        let yellow = UIColor(red:0.87, green:0.81, blue:0.25, alpha:1.0)
        let red = UIColor(red:0.95, green:0.35, blue:0.33, alpha:1.0)
        colors = [gray, blue, orange, green, pink, brown, purple, yellow, red]
        var preparedColors: [UIColor] = []
        let colorCount: Int = colors.count
        var colorIndex: Int = 0
        
        for _ in 0..<dataEntries.count {
            preparedColors.append(colors[colorIndex])
            colorIndex += 1
            if colorIndex == colorCount {
                colorIndex = 1 // cycle back but start with blue
            }
        }
        
        dataSet.colors = preparedColors
        dataSet.entryLabelColor = .black
        dataSet.xValuePosition = .outsideSlice
        dataSet.drawValuesEnabled = false
        
        pieChart.centerText = "Portfolio"
//        pieChart.holeRadiusPercent = 0.25
        pieChart.noDataText = "No data available"
        pieChart.transparentCircleColor = UIColor.clear
        pieChart.chartDescription?.enabled = false
        pieChart.highlightPerTapEnabled = false
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
            let percentageNumber = coin.value / totalValue * 100
            cell.percentage.text = String(format: "%.1f", percentageNumber) + " %"
            return cell
            
        } else {
            return ChartCoinCell()
        }
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if let cell = chartTable.cellForRow(at: indexPath) {
            if cell.isSelected {
                print("cell is selected")
                chartTable.deselectRow(at: indexPath, animated: false)
                pieChart.highlightValue(nil)
                return nil
            } else {
                pieChart.highlightValue(x: Double(indexPath.row), dataSetIndex: 0)
            }
        }
        return indexPath
    }
    
}
