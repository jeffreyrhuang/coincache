//
//  CoinHoldingCell.swift
//  coins
//
//  Created by Jeff on 10/29/17.
//  Copyright © 2017 Jeff. All rights reserved.
//

import UIKit

class CoinHoldingCell: UITableViewCell {
    
    // outlets for cell parts..

    @IBOutlet weak var coinLogo: UIImageView!
    @IBOutlet weak var coinSymbol: UILabel!
    @IBOutlet weak var coinName: UILabel!
    @IBOutlet weak var quantity: UILabel!
    @IBOutlet weak var value: UILabel!
    @IBOutlet weak var price: UILabel!
    
    func updateViews(ownedCoin: Coin) {
//        coinLogo.image = UIImage(named: ownedCoin.logo)
        coinSymbol.text = ownedCoin.symbol
        coinName.text = ownedCoin.name
        quantity.text = "\(ownedCoin.quantity)"
        value.text = "\(ownedCoin.quantity * Double(ownedCoin.price_usd)!)"
        price.text = "\(ownedCoin.price_usd)"
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
