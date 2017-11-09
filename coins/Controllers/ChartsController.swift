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
    
    let sampleCoins = ["Bitcoin", "Dash", "Lisk", "Vertcoin"]
    let coinValues = [6000.0, 500.0, 200.0, 3000.0]
    
    
    @IBOutlet weak var pieChart: PieChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setChart()
        
    }
    
    func setChart() {
        var dataEntries: [PieChartDataEntry] = []
        
        dataEntries.append(PieChartDataEntry(value: 6000.0, label: "Bitcoin"))
        dataEntries.append(PieChartDataEntry(value: 4000.0, label: "Litecoin"))
        
        let dataSet = PieChartDataSet(values: dataEntries, label: "")
        let data = PieChartData(dataSet: dataSet)
        pieChart.data = data
        
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
        
    }


}

