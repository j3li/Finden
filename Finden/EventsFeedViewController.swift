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
        eventsTableView.rowHeight = 200
        eventsTableView.reloadData()
        
        let query = PFQuery(className: "Events")
        
        query.includeKeys(["eventName","eventDate", "eventCaption","eventImage"])
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
        let event = events[indexPath.row]
        let imageFile = event["eventImage"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string: urlString)!
        
        let cell = eventsTableView.dequeueReusableCell(withIdentifier: "EventCell") as! EventCell
        cell.eventnameLabel.text = event["eventName"] as? String
        cell.eventcaptionLabel.text = event["eventCaption"] as? String
        cell.eventdateLabel.text = event["eventDate"] as? String
        cell.eventImageView.af_setImage(withURL: url)
        cell.eventImageView.layer.cornerRadius = 10
        
        return cell
    }
    
    //sending data
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Get the new vi
        //Find the selected movie
        if segue.identifier == "EventDetailSegue" {
            let cell = sender as! UITableViewCell
            let indexPath = eventsTableView.indexPath(for: cell)!
            let event = events[indexPath.row]
            
            //Pass the selected movie to the details view controller
            let detailViewController = segue.destination as! EventDetailViewController
            detailViewController.event = event
            eventsTableView.deselectRow(at: indexPath, animated: true)
        }
    }
    

    @IBAction func onCreate(_ sender: Any) {
        performSegue(withIdentifier: "CreateSegue", sender: self)
    }
    
    
    
    
    
    
}
