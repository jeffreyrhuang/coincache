//
//  AddCoinCell.swift
//  coins
//
//  Created by Jeff on 11/6/17.
//  Copyright © 2017 Jeff. All rights reserved.
//

import UIKit

@objc protocol AddCoinDelegate: class {
    func coinAdded(sender: AddCoinCell)
}

class AddCoinCell: UITableViewCell {
    
    weak var delegate: AddCoinDelegate?

    @IBOutlet weak var rank: UILabel!
    @IBOutlet weak var symbol: UILabel!
    @IBOutlet weak var name: UILabel!
    
    @IBAction func addButtonPressed(_ sender: Any) {
        delegate?.coinAdded(sender: self)
    }
    
    
    func updateViews(coin: Coin) {
        name.text = coin.name
        symbol.text = coin.symbol
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
