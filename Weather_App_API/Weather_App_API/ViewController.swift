//
//  ViewController.swift
//  Weather_App_API
//
//  Created by Vlad Tagunkov on 14/06/2019.
//  Copyright © 2019 TVI Software. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var locationLabelConnect: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var appearanceTemperatureLabel: UILabel!
    
    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    let locationManager = CLLocationManager()
    
    
    
    @IBAction func refreshButtonTapped(_ sender: UIButton) {
        toggleActivityIndictor(on: true)
        getCurrentWeatherData()
        
    }
    func toggleActivityIndictor(on: Bool) {
        refreshButton.isHidden = on
        if on {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
    
    
    
    lazy var weatherManager = APIWeatherManager(apiKey: "###")
    let coordinates = Coordinates(latitude: 50.072925, longitude: 14.472530)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    
        getCurrentWeatherData()
        
        
        
        // EASY BUT NOT CORRECT DATA FETCH METHOD!
//        let icon = WeatherIconManager.Rain.image
//        let currentWeather = CurrentWeather(temperature: 10.0, appearanceTemperature: 9.0, humidity: 25.0, pressure: 750, icon: icon)
        // updateUIWith(currentWeather: currentWeather)
        
        // YOU need own API key from - https://darksky.net/dev/register - make free reg and get the Key.
        //        let urlString = "https://api.darksky.net/forecast/###/37.8267,-122.4233"
        //        let baseUrl =  URL(string: "https://api.darksky.net/forecast/###/")
//        let fullURL = URL(string: "37.8267,-122.4233", relativeTo: baseUrl)
//
//        let sessionconfiguration = URLSessionConfiguration.default
//        let session = URLSession(configuration: sessionconfiguration)
//
//        let request = URLRequest(url: fullURL!)
//        let dataTask = session.dataTask(with: fullURL!) { (data, responce, error) in
//
//        }
//        dataTask.resume()
        
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation = locations.last! as CLLocation
        print("My location latitude: \(userLocation.coordinate.latitude), longitude: \(userLocation.coordinate.longitude)")
        
    }
    
    func getCurrentWeatherData(){
        weatherManager.fetchCurrentWeatherWith(coordinates: coordinates) { (result) in
            self.toggleActivityIndictor(on: false)
            
            switch result {
            case .Success(let currentWeather):
                self.updateUIWith(currentWeather: currentWeather)
            case .Failure(let error as NSError):
                let alertController = UIAlertController(title: "Unable to open Data", message: "\(error.localizedDescription)", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            default: break
            }
        }
        
    }
    
    
    
    
    func updateUIWith(currentWeather: CurrentWeather){
        self.imageView.image = currentWeather.icon
        self.pressureLabel.text = currentWeather.pressureString
        self.temperatureLabel.text = currentWeather.temperatureString
        self.appearanceTemperatureLabel.text = "Feels like " + currentWeather.appearentTemperatureString
        self.humidityLabel.text = currentWeather.humidityString
    }
}


