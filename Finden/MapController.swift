//
//  MapController.swift
//  Finden
//
//  Created by Alan Cao on 4/29/20.
//  Copyright © 2020 Finden. All rights reserved.
//

import UIKit
import MapKit

class MapController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet var mapView: MKMapView!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureMapUI()
    }
    
    func configureMapUI() {
 
    }
}
