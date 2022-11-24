//
//  ViewController.swift
//  WeatherApp
//
//  Created by Даша Волошина on 24.11.22.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        createLocation()
    }
    
    func createLocation() {
        
        locationManager.requestWhenInUseAuthorization()
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled(){
                if CLLocationManager.authorizationStatus() == .authorized {
                self.locationManager.startUpdatingLocation()
                       } else {
                       }
                self.locationManager.requestWhenInUseAuthorization()
                self.locationManager.requestAlwaysAuthorization()
                   }
        }
       
    }
    
    func createUrl(latitude:Double,longitude:Double){
        let url = URL(string: "https://api.open-meteo.com/v1/forecast?latitude=\(latitude.description).90&longitude=\(longitude.description)&daily=temperature_2m_max,temperature_2m_min,windspeed_10m_max&timezone=Europe%2FMoscow&start_date=2022-11-24&end_date=2022-11-24")!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        //        urlRequest.allHTTPHeaderFields = ["auToken":"nil"]
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response,error in
            guard let data = data else {return}
            print(String(data:data, encoding: .utf8))
            
            do {
                let jsonDecoder = JSONDecoder()
                let finalData = try jsonDecoder.decode(WeatherData.self, from: data)
                print(finalData.longitude.description)
                
            } catch let error {
                print(error)
            }
            
        }
        task.resume()
        print(task)
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.first {
            createUrl(latitude:location.coordinate.latitude, longitude:location.coordinate.longitude)
            print(location.coordinate.latitude, location.coordinate.longitude)
        }
    }
}


