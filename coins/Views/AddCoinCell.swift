//
//  AddCoinCell.swift
//  coins
//
//  Created by Jeff on 11/6/17.
//  Copyright © 2017 Jeff. All rights reserved.
//

import UIKit

class AddCoinCell: UITableViewCell {

    @IBOutlet weak var rank: UILabel!
    @IBOutlet weak var name: UILabel!
    
    func updateViews(coin: Coin) {
        name.text = coin.name
        rank.text = coin.rank + "."
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
