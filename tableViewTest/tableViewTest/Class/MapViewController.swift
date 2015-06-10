//
//  MapViewController.swift
//  tableViewTest
//
//  Created by JsonWang on 15/6/9.
//  Copyright (c) 2015年 cn.jsonWang. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    
    @IBOutlet var mapView:MKMapView!
    var restaurant:Restaurant!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //convert address to coordinate and annotate it an map
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(restaurant.location, completionHandler: { placemarks,error in
            if error != nil{
                println(error)
                return
            }
            
            if placemarks != nil && placemarks.count > 0{
                let placemark = placemarks[0] as! CLPlacemark
                //add annotation
                
                let annotation = MKPointAnnotation()
                annotation.title = self.restaurant.name
                annotation.subtitle = self.restaurant.type
                annotation.coordinate = placemark.location.coordinate
                
                self.mapView.showAnnotations([annotation], animated: true)
                self.mapView.selectAnnotation(annotation, animated: true)
            }
            })
    }


}
