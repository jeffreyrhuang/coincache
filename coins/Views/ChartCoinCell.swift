//
//  ChartCoinCell.swift
//  coins
//
//  Created by Jeff on 11/10/17.
//  Copyright © 2017 Jeff. All rights reserved.
//

import UIKit

class ChartCoinCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var percentage: UILabel!
    
    func updateViews(coin: Coin) {
        name.text = coin.name
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
