//
//  ItemCreationController.swift
//  Finden
//
//  Created by Alan Cao on 5/8/20.
//  Copyright © 2020 Finden. All rights reserved.
//

import UIKit
import Parse

class ItemCreationController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet var createImageView: UIImageView!
    @IBOutlet var itemTextField: UITextField!
    @IBOutlet var itemTextView: UITextView!
    @IBOutlet var postButton: UIButton!
    
    private let tapGesture = UITapGestureRecognizer()
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        postButton.layer.cornerRadius = 44 / 2
        view.addGestureRecognizer(tapGesture)
        tapGesture.addTarget(self, action: #selector(handleDismissal))
    }
    
    // MARK: - Actions
    
    @objc func handleDismissal() {
        view.endEditing(true)
    }
    
    @IBAction func handlePostTapped(_ sender: Any) {
        guard let imageData = createImageView.image?.pngData() else { return }
        guard let item = itemTextField.text else { return }
        guard let description = itemTextView.text else { return }
        
        let file = PFFileObject(name: "image.png", data: imageData)
        let freeItems = PFObject(className: "Items")
        
        freeItems["itemName"] = item
        freeItems["itemDescription"] = description
        freeItems["itemImage"] = file
        
        freeItems.saveInBackground { (success, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func handleCreateTapped(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
}

extension ItemCreationController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        
        createImageView.image = image
        createImageView.clipsToBounds = true
        
        dismiss(animated: true, completion: nil)
    }
}
