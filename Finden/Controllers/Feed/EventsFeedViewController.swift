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

class EventsFeedViewController: UITableViewController {

    @IBOutlet var eventsTableView: UITableView!
    
    var events = [PFObject]() {
        didSet { eventsTableView.reloadData() } // Makes sure we have events before we reload the data
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        eventsTableView.rowHeight = 150
        eventsTableView.reloadData()
        
        let query = PFQuery(className: "Events")
        
        query.includeKeys(["eventName","eventDate", "eventCaption","eventImage"])
        query.limit = 20
        query.findObjectsInBackground { (events, error) in
            if events != nil {
                self.events = events!
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let cell = sender as? UITableViewCell else { return }
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let event = events[indexPath.row]

        let controller = segue.destination as! EventDetailsController
        controller.event = event
        eventsTableView.deselectRow(at: indexPath, animated: true)
    }
}

extension EventsFeedViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
