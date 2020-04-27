//
//  LandingController.swift
//  Finden
//
//  Created by Alan Cao on 4/27/20.
//  Copyright © 2020 Finden. All rights reserved.
//

import UIKit

class LandingController: UIViewController {
    @IBOutlet var signInButton: UIButton!
    @IBOutlet var signUpButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
        roundButtons()
    }
    
    @IBAction func handleSignInTapped(_ sender: Any) {
        
    }
    
    func roundButtons() {
        signInButton.layer.cornerRadius = 44 / 2
        signUpButton.layer.cornerRadius = 44 / 2
    }
}
