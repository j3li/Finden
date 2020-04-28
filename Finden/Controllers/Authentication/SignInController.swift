//
//  SignInController.swift
//  Finden
//
//  Created by Alan Cao on 4/27/20.
//  Copyright © 2020 Finden. All rights reserved.
//

import UIKit
import Parse

class SignInController: UIViewController {
    @IBOutlet var signInButton: UIButton!
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
    
    @IBAction func handleSignInTapped(_ sender: Any) {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        PFUser.logInWithUsername(inBackground: email, password: password) { (user, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            self.performSegue(withIdentifier: "loginSegue", sender: nil)
        }
    }
    
    func roundButtons() {
        signInButton.layer.cornerRadius = 44 / 2
    }
}
