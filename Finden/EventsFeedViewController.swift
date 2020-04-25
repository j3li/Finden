//
//  EventsFeedViewController.swift
//  Finden
//
//  Created by 김송은 on 4/24/20.
//  Copyright © 2020 Finden. All rights reserved.
//

import UIKit
import Parse

class EventsFeedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var eventsTableView: UITableView!
    
    var events = [PFObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        eventsTableView.delegate = self
        eventsTableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let query = PFQuery(className: "Events")
        
        query.includeKey("author")
        query.limit = 20
        query.findObjectsInBackground { (events, error) in
            if events != nil {
                self.events = events!
                self.eventsTableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = eventsTableView.dequeueReusableCell(withIdentifier: "EventCell") as! EventCell
        
        let event = events[indexPath.row]
        
        let user = event["author"] as! PFUser
        cell.eventnameLabel.text = event["event name"] as? String
        cell.eventlocationLabel.text = event["event location"] as? String
        cell.eventdateLabel.text = event["event date"] as? String

        //something for image too
        
        return cell
    }
    
    //sending data
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Get the new vi
        //Find the selected movie
        if segue.identifier == "EventDetailSegue"{
            let cell = sender as! UITableViewCell
            let indexPath = eventsTableView.indexPath(for: cell)!
            let event = events[indexPath.row]
            
            //Pass the selected movie to the details view controller
            let detailViewController = segue.destination as! EventDetailViewController
            detailViewController.event = event
            
            eventsTableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    @IBAction func createButton(_ sender: Any) {
        performSegue(withIdentifier: "CreateSegue", sender: self)
    }
    
}
