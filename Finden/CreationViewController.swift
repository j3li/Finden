//
//  CreationViewController.swift
//  Finden
//
//  Created by 김송은 on 4/24/20.
//  Copyright © 2020 Finden. All rights reserved.
//

import UIKit
import Parse

class CreationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var eventnameField: UITextField!
    
    @IBOutlet weak var eventlocationField: UITextField!
    
    @IBOutlet weak var eventdateField: UITextField!
    
    @IBOutlet weak var eventcaptionTextView: UITextView!
    
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func postButton(_ sender: Any) {
        let event = PFObject(className: "Events")
        
        event["event caption"] = eventcaptionTextView
        event["event name"] = eventnameField
        event["event location"] = eventlocationField
        event["event date"] =  eventdateField
        //**For user, maybe displaying username of PFUser would be better maybe? -> For Event Screen
        event["author"] = PFUser.current()!
        
        //need something for image too
        
        //save post
        event.saveInBackground { (success, error) in
            if success {
                self.dismiss(animated: true, completion: nil)
                print("saved!")
            } else {
                print("error!")
            }
        }
        
    }
}
