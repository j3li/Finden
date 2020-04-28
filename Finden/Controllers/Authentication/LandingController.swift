//
//  LandingController.swift
//  Finden
//
//  Created by Alan Cao on 4/27/20.
//  Copyright © 2020 Finden. All rights reserved.
//

import UIKit

class LandingController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet var signInButton: UIButton!
    @IBOutlet var signUpButton: UIButton!

    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
        roundButtons()
    }

    // MARK: - Helpers
    
    func roundButtons() {
        signInButton.layer.cornerRadius = 44 / 2
        signUpButton.layer.cornerRadius = 44 / 2
    }
}
