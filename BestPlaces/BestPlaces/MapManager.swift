//
//  MapManager.swift
//  BestPlaces
//
//  Created by Vlad Tagunkov on 12/06/2019.
//  Copyright © 2019 TVI Software. All rights reserved.
//

import UIKit
import MapKit

class MapManager {
    let locationManager = CLLocationManager()
    private var placeCoordinate: CLLocationCoordinate2D?
    private let regionInMeters = 1000.0
    private var directionsArray: [MKDirections] = []
    
    func setupPlaceMark(place: Place, mapView: MKMapView){
        guard let location = place.location else {return}
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(location) { (placemarks, error) in
            if let error = error {
                print(error)
                return
            }
            guard let placemarks = placemarks else {return}
            let placemark = placemarks.first
            let annotation = MKPointAnnotation()
            annotation.title = place.name
            annotation.subtitle = place.type
            
            guard let placemarkLocation = placemark?.location else {return}
            annotation.coordinate = placemarkLocation.coordinate
            self.placeCoordinate = placemarkLocation.coordinate
            
            
            mapView.showAnnotations([annotation], animated: true)
            mapView.selectAnnotation(annotation, animated: true)
            
        }
    }
    func checkLocationServices(mapView: MKMapView, segueIdentifier: String, closure:()->()){
        if CLLocationManager.locationServicesEnabled(){
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            checkLocationAuthorization(mapView: mapView, segueIdentifier: segueIdentifier)
            closure()
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.showAlert(title: "Location Service are Disabled", message: "To enable it go: Settings -> Privacy -> Location Services and turn On")
            }
        }
    }
    
    func checkLocationAuthorization(mapView: MKMapView, segueIdentifier: String){
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            mapView.showsUserLocation = true
            if segueIdentifier == "getAdress" {showUserLocation(mapView: mapView)}
            break
        case .denied:
            //show alert
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            break
        case .restricted:
            break
        case .authorizedAlways:
            break
        }
    }
    
    func showUserLocation(mapView: MKMapView) {
        if let location = locationManager.location?.coordinate
        {
            let region = MKCoordinateRegion(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            mapView.setRegion(region, animated: true)
            
        }
    }
    func getDirections(for mapView: MKMapView, previousLocation:(CLLocation)->()){
        guard let location = locationManager.location?.coordinate else {
            showAlert(title: "Error", message: "Currentlocation is not found")
            return
        }
        locationManager.startUpdatingLocation()
        previousLocation(CLLocation(latitude: location.latitude, longitude: location.longitude))
        
        
        guard let request = createDirectionRequests(from: location) else {
            showAlert(title: "Error", message: "Destination not found")
            return
        }
        let directions = MKDirections(request: request)
        resetMapView(withNew: directions, mapView: mapView)
        
        
        directions.calculate { (response, error) in
            if let error = error {
                print(error)
                return
            }
            guard let response = response else {
                self.showAlert(title: "Error", message: "Direction is not awailable")
                return
            }
            for route in response.routes {
                mapView.addOverlay(route.polyline)
                mapView.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
                
                let distance = String( format: "%.1f",route.distance / 1000)
                let timeInterval = route.expectedTravelTime
                
                print("Distance to place: \(distance) km.")
                print("Time in way will be: \(timeInterval) seconds.")
            }
        }
        
    }
   func resetMapView(withNew deirections: MKDirections, mapView: MKMapView){
        mapView.removeOverlays(mapView.overlays)
        directionsArray.append(deirections)
        
        let _ = directionsArray.map { $0.cancel()
        }
        directionsArray.removeAll()
    }

    func createDirectionRequests(from coordinate: CLLocationCoordinate2D) -> MKDirections.Request? {
        guard let destinationCoordinate = placeCoordinate else {return nil}
        let startingLocation = MKPlacemark(coordinate: coordinate)
        let destination = MKPlacemark(coordinate: destinationCoordinate)
        
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: startingLocation)
        request.destination = MKMapItem(placemark: destination)
        request.transportType = .automobile
        request.requestsAlternateRoutes = true
        
        return request
    }
    func startTrackingUserLocation(for mapView: MKMapView, and location: CLLocation?, closure:(_ currentLocation: CLLocation)->()){
        guard let location = location else {return}
        let center = getcenterlocation(for: mapView)
        guard center.distance(from: location) > 50 else {return}
        closure(center)
    }
    
   func getcenterlocation(for mapView: MKMapView) -> CLLocation{
        let latitude = mapView.centerCoordinate.latitude
        let longitude = mapView.centerCoordinate.longitude
        
        return CLLocation(latitude: latitude, longitude: longitude)
    }
    
    
    
    private func showAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        
        alert.addAction(okAction)
        let alertWindow = UIWindow(frame: UIScreen.main.bounds)
        alertWindow.rootViewController = UIViewController()
        alertWindow.windowLevel  = UIWindow.Level.alert + 1
        alertWindow.makeKeyAndVisible()
        alertWindow.rootViewController?.present(alert, animated: true)
        
    }
   
    
    
}
