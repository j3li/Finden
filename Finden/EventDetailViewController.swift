//
//  EventDetailViewController.swift
//  Finden
//
//  Created by 김송은 on 4/25/20.
//  Copyright © 2020 Finden. All rights reserved.
//

import UIKit
import Parse

class EventDetailViewController: UIViewController {
    
    @IBOutlet weak var eventImageView: UIImageView!
    
    @IBOutlet weak var eventnameLabel: UILabel!
    
    @IBOutlet weak var eventlocationLabel: UILabel!
    
    @IBOutlet weak var eventdateLabel: UILabel!
    
    @IBOutlet weak var eventcaptionTextView: UITextView!
    
    //Is this a correct way to initialize event?
    var event = PFObject(className: "Events")
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        eventnameLabel.text = event["event name"] as? String
        eventlocationLabel.text = event["event location"] as? String
        eventdateLabel.text = event["event date"] as? String
        eventcaptionTextView.text = event["event caption"] as? String
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
