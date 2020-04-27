//
//  RegisterViewController.swift
//  Finden
//
//  Created by 김송은 on 4/25/20.
//  Copyright © 2020 Finden. All rights reserved.
//

import UIKit
import Parse

class RegisterViewController: UIViewController {

    
    @IBOutlet weak var firstnameField: UITextField!
    @IBOutlet weak var lastnameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onSignUp(_ sender: Any) {
        let user = PFUser()
        user.username = emailField.text
        user.password = passwordField.text
        user["firstName"] = firstnameField.text
        user["lastName"] = lastnameField.text
        
        user.signUpInBackground { (success, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            print("Successfully registered user")
            self.performSegue(withIdentifier: "registeredSegue", sender: nil)
//            if success {
//                print("success")
//                self.performSegue(withIdentifier: "registeredSegue", sender: nil)
//                print("success")
//            } else {
//                print("Error: \(error?.localizedDescription)")
//            }
        }
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
