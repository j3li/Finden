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
import CoreLocation

class CreationController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet var createButton: UIButton!
    
    @IBOutlet weak var eventnameField: UITextField!
    @IBOutlet weak var eventlocationField: UITextField!
    @IBOutlet weak var eventdateField: UITextField!
    @IBOutlet weak var eventcaptionTextView: UITextView!
    @IBOutlet weak var createImageView: UIImageView!
    
    private let tapGesture = UITapGestureRecognizer()
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createButton.layer.cornerRadius = 44 / 2
        view.addGestureRecognizer(tapGesture)
        tapGesture.addTarget(self, action: #selector(handleDismissal))
    }
    
    // MARK: - Actions
    
    @objc func handleDismissal() {
        view.endEditing(true)
    }
    
    @IBAction func handleCreateEventTapped(_ sender: Any) {
        guard let imageData = createImageView.image?.pngData() else { return }
        guard let caption = eventcaptionTextView.text else { return }
        guard let name = eventnameField.text else { return }
        guard let date = eventdateField.text else { return }
        guard let location = eventlocationField.text else { return }
        
        let file = PFFileObject(name: "image.png", data: imageData)
        let event = PFObject(className: "Events")
        
        event["eventCaption"] = caption
        event["eventName"] = name
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(location) {
            (placemarks, error) in
            let placemark = placemarks?.first?.location
            let lat = placemark?.coordinate.latitude
            let lon = placemark?.coordinate.longitude
            let clLocation = CLLocation(latitude: lat!, longitude: lon!)
            event["eventLocation"] = clLocation
        }
        event["eventDate"] =  date
        event["eventImage"] = file

        event.saveInBackground { (success, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            self.navigationController?.popViewController(animated: true)
        }
    }
}

extension CreationController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBAction func handleImageViewTapped(_ sender: UITapGestureRecognizer) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        guard let image = info[.editedImage] as? UIImage else { return }
        
        createImageView.image = image
        createImageView.clipsToBounds = true

        dismiss(animated: true, completion: nil)
    }
}

extension CreationController : UITextFieldDelegate {
    
}
