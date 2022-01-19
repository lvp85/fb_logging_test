//
//  GoogleMapViewController.swift
//  FbloggigAccount
//
//  Created by Udagedara Dehigama on 2022/01/19.
//

import UIKit
// calling google map
import GoogleMaps

class GoogleMapViewController: UIViewController {
    // varible define
    var G_lati: Double = 0.0
    var G_long: Double = 0.0
    var G_address : String?
    // create view
    @IBOutlet weak var google_Map: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
       // locate location on google map
        let camera = GMSCameraPosition.camera(withLatitude: G_lati, longitude: G_long, zoom: 8.0)
               let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
               view = mapView
                // create  marker
               let marker = GMSMarker()
               marker.position = CLLocationCoordinate2D(latitude:G_lati, longitude: G_long)
        //set address to title
               marker.title = G_address
              
               marker.map = mapView
           }

    

}
