//
//  ItemsController.swift
//  Finden
//
//  Created by Alan Cao on 5/8/20.
//  Copyright © 2020 Finden. All rights reserved.
//

import UIKit
import Parse
import AlamofireImage

class ItemsController: UIViewController {
    
    // MARK: - Properties
    
    var items = [PFObject]() {
        didSet { tableView.reloadData() }
    }
    
    @IBOutlet var tableView: UITableView!
    
    // MARK: - Lifecycles
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.rowHeight = 150
        tableView.reloadData()
        
        let query = PFQuery(className: "Items")
        
        query.includeKeys(["itemName","itemImage", "itemDescription"])
        query.limit = 20
        query.findObjectsInBackground { (items, error) in
            if let items = items {
                self.items = items
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let cell = sender as? UITableViewCell else { return }
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let item = items[indexPath.row]

        let controller = segue.destination as! ItemDetailsController
        controller.items = item
        tableView.deselectRow(at: indexPath, animated: true)
    }
    @IBAction func onSignOut(_ sender: Any) {
        PFUser.logOut()
        
        let main = UIStoryboard(name: "Main", bundle: nil)
        let LandingController = main.instantiateViewController(withIdentifier: "LandingNavigationController")
        
        let delegate = self.view.window?.windowScene?.delegate as! SceneDelegate
        delegate.window?.rootViewController = LandingController
    }
}

extension ItemsController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        let imageFile = item["itemImage"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string: urlString)!
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemsCell") as! ItemsCell
        cell.itemName.text = item["itemName"] as? String
        cell.itemImage.af_setImage(withURL: url)

        return cell
    }
}
extension ItemsController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let query = PFQuery(className: "Items")
            
        query.includeKeys(["itemName","itemImage", "itemDescription"])
        query.limit = 20
        query.whereKey("itemName", matchesRegex: searchText, modifiers: "i")
        query.findObjectsInBackground { (items, error) in
            if let items = items {
                self.items = items
            }
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        let query = PFQuery(className: "Items")
        
        query.includeKeys(["itemName","itemImage", "itemDescription"])
        query.limit = 20
        query.findObjectsInBackground { (items, error) in
            if let items = items {
                self.items = items
            }
        }
        tableView.reloadData()
    }
    
}


