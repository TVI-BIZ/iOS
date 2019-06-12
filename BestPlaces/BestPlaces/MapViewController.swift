//
//  MapViewController.swift
//  BestPlaces
//
//  Created by Vlad Tagunkov on 11/06/2019.
//  Copyright © 2019 TVI Software. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

protocol MapViewControllerDelegate {
    func getAdress(adress: String?)
}


class MapViewController: UIViewController {
    var mapViewControllerDelegate: MapViewControllerDelegate?
    
    @IBOutlet weak var goButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var adressLabel: UILabel!
    @IBOutlet weak var mapPinImage: UIImageView!
    @IBAction func centerViewInUserLocation() {
       mapManager.showUserLocation(mapView: mapView)
        
    }
    @IBAction func closeVC() {
        
        dismiss(animated: true)
    }
    
    @IBOutlet weak var mapView: MKMapView!
    
    let mapManager = MapManager()
    //var mapViewControllerDelegate: MapViewControllerDelegate?
    
    var place =  Place()
    let annotationIdentifier = "annotationIdentifier"
    var incomeSegueIdentifier = ""
    var previousLocation: CLLocation? {
        didSet{
            mapManager.startTrackingUserLocation(for: mapView, and: previousLocation) { (currentLocation) in
                self.previousLocation = currentLocation
                
                DispatchQueue.main.asyncAfter(deadline: .now()+3, execute: {
                    self.mapManager.showUserLocation(mapView: self.mapView)
                })
            }
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        adressLabel.text = ""
        mapView.delegate = self
        setupMavView()
       

        // Do any additional setup after loading the view.
    }
    private func setupMavView(){
        goButton.isHidden = true
        
        mapManager.checkLocationServices(mapView: mapView, segueIdentifier: incomeSegueIdentifier) {
            mapManager.locationManager.delegate = self
        }
        
        if incomeSegueIdentifier == "showPlace" {
            mapManager.setupPlaceMark(place: place, mapView: mapView)
            mapPinImage.isHidden = true
            adressLabel.isHidden = true
            doneButton.isHidden = true
            goButton.isHidden = false
            
        }
    }
 
    
    
//    private func setupLocationManager(){
//        locationManager.delegate = self
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//    }
   
 

  
    
    @IBAction func goButtonPressed() {
        mapManager.getDirections(for: mapView) { (location) in
            self.previousLocation = location
        }
    }
    @IBAction func doneButtonPressed() {
        mapViewControllerDelegate?.getAdress(adress: adressLabel.text)
        dismiss(animated: true)
        
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else {return nil}
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier) as? MKPinAnnotationView
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
            annotationView?.canShowCallout = true
        }
        if let imageData = place.imageData {
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
            imageView.layer.cornerRadius = 10
            imageView.clipsToBounds = true
            imageView.image = UIImage(data: imageData)
            annotationView?.rightCalloutAccessoryView = imageView
        }
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let center = mapManager.getcenterlocation(for: mapView)
        
        let geocoder = CLGeocoder()
        
        if incomeSegueIdentifier == "showPlace" && previousLocation != nil {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.mapManager.showUserLocation(mapView: self.mapView)
            }
        }
        geocoder.cancelGeocode()
        
        
        geocoder.reverseGeocodeLocation(center) { (placemark, error) in
            if let error = error {
                print(error)
                return
            }
            guard let placemarks = placemark else {return}
            let placemark = placemarks.first
            let streetName = placemark?.thoroughfare
            let buildnumber = placemark?.subThoroughfare
            
            DispatchQueue.main.async {
                if streetName != nil && buildnumber != nil {
                        self.adressLabel.text = "\(streetName!), \(buildnumber!)"
                } else if streetName != nil {
                    self.adressLabel.text = "\(streetName!)"
                } else {
                    self.adressLabel.text = ""
                }
            }
        }
    }
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay as! MKPolyline)
        renderer.strokeColor = .red
        return renderer
    }
    
}
extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        mapManager.checkLocationAuthorization(mapView: mapView, segueIdentifier: incomeSegueIdentifier)
    }
}
