//
//  ItemsController.swift
//  Finden
//
//  Created by Alan Cao on 5/8/20.
//  Copyright © 2020 Finden. All rights reserved.
//

import UIKit

class ItemsController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet var tableView: UITableView!
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

extension ItemsController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemsCell
        
        return cell
    }
    
    
}


