//
//  EventDetailViewController.swift
//  Finden
//
//  Created by 김송은 on 4/25/20.
//  Copyright © 2020 Finden. All rights reserved.
//

import UIKit
import Parse
import AlamofireImage

class EventDetailsController: UIViewController {
   
    // MARK: - Outlets
    
    @IBOutlet var eventImageView: UIImageView!
    @IBOutlet var eventName: UILabel!
    @IBOutlet var eventLocation: UILabel!
    @IBOutlet var eventDate: UILabel!
    @IBOutlet var eventTextView: UITextView!
    
    var event: PFObject!
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        let imageFile = event["eventImage"] as! PFFileObject
        guard let urlString = imageFile.url else { return }
        guard let url = URL(string: urlString) else { return }
        
        eventImageView.af_setImage(withURL: url)
        eventName.text = event["eventName"] as? String ?? ""
        eventLocation.text = event["eventLocation"] as? String ?? ""
        eventDate.text = event["eventDate"] as? String ?? ""
        eventTextView.text = event["eventCaption"] as? String ?? ""
        title = event["eventName"] as? String ?? ""
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
