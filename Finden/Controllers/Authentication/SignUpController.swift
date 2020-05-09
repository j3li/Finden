//
//  SignUpController.swift
//  Finden
//
//  Created by Alan Cao on 4/27/20.
//  Copyright © 2020 Finden. All rights reserved.
//

import UIKit
import Parse

class SignUpController: UIViewController {
    @IBOutlet var signUpButton: UIButton!
    @IBOutlet var firstnameTextField: UITextField!
    @IBOutlet var lastnameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        roundButtons()
    }
    
    @IBAction func handleSignUpTapped(_ sender: Any) {
        let user = PFUser()
        user.username = emailTextField.text
        user.password = passwordTextField.text
        user["firstName"] = firstnameTextField.text
        user["lastName"] = lastnameTextField.text
        
        if(firstnameTextField.text!.isEmpty || lastnameTextField.text!.isEmpty) {
               let alert = UIAlertController(title: "Error", message: "Please fill in all fields", preferredStyle: UIAlertController.Style.alert)
                   alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
                   self.present(alert, animated: true, completion: nil)
               }
               else {
                   user.signUpInBackground { (success, error) in
                       if let error = error {
                           print("Error: \(error.localizedDescription)")
                           return
                       }
                       print("Successfully registered user")
                       self.performSegue(withIdentifier: "registeredSegue", sender: nil)
                   }
               }
    }
    
    func roundButtons() {
        signUpButton.layer.cornerRadius = 44 / 2
    }
}
