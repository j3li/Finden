//
//  MapViewController.swift
//  Finden
//
//  Created by user169276 on 5/9/20.
//  Copyright © 2020 Finden. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import AddressBookUI
import MessageUI
import Parse
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    var events = [PFObject]();
    override func viewDidLoad() {
        //super.viewDidLoad()
        mapView.delegate = self
        //Centers map on UCSD
        let mapCenter = CLLocationCoordinate2D(latitude: 32.881173, longitude: -117.237586)
        let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: mapCenter, span: mapSpan)
        mapView.setRegion(region, animated: true)
        /*
         
        let query = PFQuery(className: "Events")
        query.includeKey("eventLocation")
        query.limit = 20
        query.findObjectsInBackground { (eventList, error) in
            if eventList != nil {
                self.events = eventList!
                self.mapView.reloadInputViews()
            }
        }
    }

    func addPin(locationCoordinate:CLLocationCoordinate2D, eventName:String){
        let annotation = MKPointAnnotation()
        annotation.coordinate = locationCoordinate
        annotation.title = eventName
        mapView.addAnnotation(annotation)
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView){
        for event in events {
            let locEvent = event["eventLocation"] as! CLLocationCoordinate2D
            let eventName = event["eventName"] as! String
            addPin(locationCoordinate: locEvent, eventName: eventName)
        }
        if let annotation = view.annotation {
            if let title = annotation.title! {
                print("boinked \(title)")
            }
        }
*/
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
