//
//  AddCoinController.swift
//  coins
//
//  Created by Jeff on 11/6/17.
//  Copyright © 2017 Jeff. All rights reserved.
//

import UIKit
import RealmSwift

class AddCoinController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, AddCoinDelegate {
    // use do catch
    let realm = try! Realm()
    var allCoins: Results<Coin>?
    var filteredCoins: Results<Coin>?
    var isSearching = false
    var coinToBeAdded: Coin?

    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var addCoinTable: UITableView!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.allCoins = self.realm.objects(Coin.self)
        
        addCoinTable.dataSource = self
        addCoinTable.delegate = self
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done

    }
    
    // Mark: - Delegate
    
    func coinAdded(sender: AddCoinCell) {
        if let indexPath = addCoinTable.indexPath(for: sender) {
            if isSearching {
                coinToBeAdded = filteredCoins![indexPath.row]
                
            } else {
                coinToBeAdded = allCoins![indexPath.row]
            }
//            performSegue(withIdentifier: "goToCoinAmount", sender: self)
            
        }
    }

    // Mark: - Search bar
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            isSearching = false
            view.endEditing(true)
            addCoinTable.reloadData()
        } else {
            isSearching = true
            let predicate = NSPredicate(format: "name BEGINSWITH [c]%@ OR symbol BEGINSWITH [c]%@", searchBar.text!, searchBar.text!)
            filteredCoins = realm.objects(Coin.self).filter(predicate)
            addCoinTable.reloadData()
        }
    }
    

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if isSearching {
            return filteredCoins!.count
        }
        return allCoins!.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "AddCoinCell") as? AddCoinCell {
            cell.delegate = self
            
            if isSearching {
                let coin = filteredCoins![indexPath.row]
                cell.updateViews(coin: coin)
                return cell
                
            } else {
                let coin = allCoins![indexPath.row]
                cell.updateViews(coin: coin)
                return cell
            }
            
            
        } else {
            return AddCoinCell()
        }
    }
    
    // Mark: Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToCoinAmount" {
            let addCoinAmountController = segue.destination as! AddCoinAmountController
            
            addCoinAmountController.addedCoin = coinToBeAdded
        }
    }
}
