//
//  AddCoinAmountController.swift
//  coins
//
//  Created by Jeff on 11/8/17.
//  Copyright © 2017 Jeff. All rights reserved.
//

import UIKit
import RealmSwift

class AddCoinAmountController: UIViewController {
    
    var addedCoin: Coin?

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var amountTextField: UITextField!
    
    @IBAction func submitButtonPressed(_ sender: Any) {
        
        do {
            let realm = try Realm()
            if let coin =  realm.object(ofType: Coin.self, forPrimaryKey: addedCoin?.id) {
                try realm.write {
                    coin.owned = true
                    coin.amount = Double(amountTextField.text!)!
                }
            }
            
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        self.performSegue(withIdentifier: "unwindToPortfolio", sender: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        amountTextField.keyboardType = UIKeyboardType.numberPad
        amountTextField.becomeFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        name.text = addedCoin?.name
        
        
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
