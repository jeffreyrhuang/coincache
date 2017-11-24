//
//  AddWatchListViewController.swift
//  coins
//
//  Created by Jeff on 11/19/17.
//  Copyright © 2017 Jeff. All rights reserved.
//

import UIKit
import RealmSwift

class AddToWatchlistViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

    let realm = try! Realm()
    var allCoins: Results<Coin>?
    var filteredCoins: Results<Coin>?
    var isSearching = false
    var coinToBeWatched: Coin?
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var addToWatchlistTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.allCoins = self.realm.objects(Coin.self)
        
        addToWatchlistTable.delegate = self
        addToWatchlistTable.dataSource = self
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done

        // Do any additional setup after loading the view.
    }
    
    // MARK: - Search bar
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            isSearching = false
            view.endEditing(true)
            addToWatchlistTable.reloadData()
        } else {
            isSearching = true
            let predicate = NSPredicate(format: "name BEGINSWITH [c]%@ OR symbol BEGINSWITH [c]%@", searchBar.text!, searchBar.text!)
            filteredCoins = realm.objects(Coin.self).filter(predicate)
            addToWatchlistTable.reloadData()
        }
    }

    // MARK: Table functions
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return filteredCoins!.count
        }
        return allCoins!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "WatchCoinCell") as? WatchCoinCell {
//            cell.delegate = self
            
            if isSearching {
                let coin = filteredCoins![indexPath.row]
//                cell.updateViews(coin: coin)
                return cell
                
            } else {
                let coin = allCoins![indexPath.row]
//                cell.updateViews(coin: coin)
                return cell
            }
        } else {
            return WatchCoinCell()
        }
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
