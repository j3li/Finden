//
//  EventsFeedViewController.swift
//  Finden
//
//  Created by 김송은 on 4/24/20.
//  Copyright © 2020 Finden. All rights reserved.
//

import UIKit
import Parse
import AlamofireImage

class EventsFeedViewController: UIViewController {


    @IBOutlet weak var eventsTableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    var events = [PFObject]() {
        didSet { eventsTableView.reloadData() } // Makes sure we have events before we reload the data
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    var search = [String]()
    var searching = false
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        eventsTableView.rowHeight = 150
        eventsTableView.reloadData()
        
        let query = PFQuery(className: "Events")
        
        query.includeKeys(["eventName","eventDate", "eventCaption","eventImage"])
        query.limit = 20
        query.findObjectsInBackground { (events, error) in
            if let events = events {
                self.events = events
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let cell = sender as? UITableViewCell else { return }
        guard let indexPath = eventsTableView.indexPath(for: cell) else { return }
        let event = events[indexPath.row]

        let controller = segue.destination as! EventDetailsController
        controller.event = event
        eventsTableView.deselectRow(at: indexPath, animated: true)
    }
    @IBAction func onSignOut(_ sender: Any) {
        PFUser.logOut()
        
        let main = UIStoryboard(name: "Main", bundle: nil)
        let LandingController = main.instantiateViewController(withIdentifier: "LandingController")
        
        let delegate = self.view.window?.windowScene?.delegate as! SceneDelegate
        delegate.window?.rootViewController = LandingController
    }
}

extension EventsFeedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            return search.count
        } else {
            return events.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let event = events[indexPath.row]
        let imageFile = event["eventImage"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string: urlString)!
        
        let cell = eventsTableView.dequeueReusableCell(withIdentifier: "EventCell") as! EventCell
            cell.eventnameLabel.text = event["eventName"] as? String
            cell.eventdateLabel.text = event["eventDate"] as? String
            cell.eventImageView.af_setImage(withURL: url)
        return cell
    }
}

    

extension EventsFeedViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let query = PFQuery(className: "Events")
        
        query.includeKeys(["eventName","eventDate", "eventCaption","eventImage"])
        query.limit = 20
        query.whereKey("eventName", matchesRegex: searchText, modifiers: "i")
        query.findObjectsInBackground { (events, error) in
            if let events = events {
                self.events = events
            }
        }
        eventsTableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        let query = PFQuery(className: "Events")
        
        query.includeKeys(["eventName","eventDate", "eventCaption","eventImage"])
        query.limit = 20
        query.findObjectsInBackground { (events, error) in
            if let events = events {
                self.events = events
            }
        }
        eventsTableView.reloadData()
    }
    
}



