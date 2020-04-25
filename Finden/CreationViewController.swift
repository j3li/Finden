//
//  CreationViewController.swift
//  Finden
//
//  Created by 김송은 on 4/24/20.
//  Copyright © 2020 Finden. All rights reserved.
//

import UIKit
import Parse
import AlamofireImage

class CreationViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var eventnameField: UITextField!
    
    @IBOutlet weak var eventlocationField: UITextField!
    
    @IBOutlet weak var eventdateField: UITextField!
    
    @IBOutlet weak var eventcaptionTextView: UITextView!
    
    @IBOutlet weak var createImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        createImageView.layer.masksToBounds = true
        createImageView.layer.cornerRadius = 20
        eventcaptionTextView.layer.cornerRadius = 4

        // Do any additional setup after loading the view.
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        let image = info[.editedImage] as! UIImage
        let size = CGSize(width: 500, height: 500)
        let scaledimage = image.af_imageScaled(to: size)
        
        createImageView.image = scaledimage
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onUpload(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
        } else {
            picker.sourceType = .photoLibrary
        }
        present(picker, animated: true, completion: nil)
    }
    
    @IBAction func onSubmit(_ sender: Any) {
        let imageData = createImageView.image!.pngData()
        let file = PFFileObject(name: "image.png", data: imageData!)
        let event = PFObject(className: "Events")
        
        event["eventCaption"] = eventcaptionTextView.text!
        event["eventName"] = eventnameField.text!
        event["eventLocation"] = eventlocationField.text!
        event["eventDate"] =  eventdateField.text!
        //**For user, maybe displaying username of PFUser would be better maybe? -> For Event Screen
        event["eventImage"] = file
        
        //event["author"] = PFUser.current()!
        
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
