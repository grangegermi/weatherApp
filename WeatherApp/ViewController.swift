//
//  ViewController.swift
//  WeatherApp
//
//  Created by Даша Волошина on 24.11.22.
//

import UIKit
import CoreLocation
import SnapKit


class ViewController: UIViewController, CLLocationManagerDelegate {
    
    var finalData = WheatherData()
    
    let locationManager = CLLocationManager()
    let labelMaxTemp = UILabel()
    let labelMinTemp = UILabel()
    let labelCity = UILabel()
    let labelWindSpedMax = UILabel()
    let labelTemperature = UILabel()
    let windSpeed = UILabel()
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(labelMaxTemp)
        view.addSubview(labelMinTemp)
        view.addSubview(labelCity)
        view.addSubview(labelWindSpedMax)
        view.addSubview(labelTemperature)
        view.addSubview(windSpeed)
        
        locationManager.delegate = self
        createLocation()
        createConsteaints()
        createStyle()
        
        let blur = UIBlurEffect(style: .systemUltraThinMaterial)

        let visualEffect = UIVisualEffectView(effect: blur)
        
        let backround = UIImageView(frame: UIScreen.main.bounds)
        
        backround.image = UIImage(named: "winter")
        backround.contentMode = UIView.ContentMode.scaleToFill
        
        backround.addSubview(visualEffect)
        visualEffect.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.right.equalToSuperview()
        }
        self.view.insertSubview(backround, at: 0)
       
    }
    
    func createStyle(){
 
        labelMinTemp.font = UIFont(name: "Noto Sans Oriya Bold", size: 14)

        labelMaxTemp.font = UIFont(name: "Noto Sans Oriya Bold", size: 14)
        
        labelTemperature.font = UIFont(name: "Noto Sans Oriya Bold", size: 30)
        labelTemperature.textAlignment = .center
        
        windSpeed.font = UIFont(name: "Noto Sans Oriya Bold", size: 22)
        windSpeed.textAlignment = .center
        
        labelCity.font = UIFont(name: "Noto Sans Oriya Bold", size: 26)
        labelCity.textAlignment = .center
 
        labelWindSpedMax.font = UIFont(name: "Noto Sans Oriya Bold", size: 14)

    }
    
    func createConsteaints(){
        
        labelCity.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(50)
             make.top.equalToSuperview().inset(200)
             make.width.equalTo(300)
             make.height.equalTo(30)
            
         }
        
        labelTemperature.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(50)
            make.top.equalToSuperview().inset(300)
            make.width.equalTo(300)
            make.height.equalTo(40)
        }
        
        windSpeed.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(450)
            make.left.equalTo(view.snp.left).inset(30)
            make.width.equalTo(300)
            make.height.equalTo(40)
        }
        
        labelMinTemp.snp.makeConstraints { make in
             make.left.equalToSuperview().inset(30)
             make.top.equalToSuperview().inset(650)
             make.width.equalTo(300)
             make.height.equalTo(30)
         }
        
        labelMaxTemp.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(30)
            make.top.equalToSuperview().inset(700)
            make.width.equalTo(300)
            make.height.equalTo(30)
        }

        labelWindSpedMax.snp.makeConstraints { make in
             make.left.equalToSuperview().inset(30)
             make.top.equalToSuperview().inset(750)
             make.width.equalTo(350)
             make.height.equalTo(30)
         }
        
    }
    
    func createLocation() {
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.startUpdatingLocation()

}
     func dataUpload() {
         labelMaxTemp.text = "Максимальная температура: \(finalData.daily.temperature_2m_max[0]) \(finalData.daily_units.temperature_2m_max)"
         labelMinTemp.text = "Минимальная температура: \(finalData.daily.temperature_2m_min[0]) \(finalData.daily_units.temperature_2m_max) "
         labelWindSpedMax.text = "Максимальная скорость ветра: \(finalData.daily.windspeed_10m_max[0]) \(finalData.daily_units.windspeed_10m_max)"
         labelCity.text = "\(finalData.timezone)"
         labelTemperature.text = "\(finalData.current_weather.temperature) \(finalData.daily_units.temperature_2m_max) "
         windSpeed.text = "Cкорость ветра: \(finalData.current_weather.windspeed) \(finalData.daily_units.windspeed_10m_max)"
}
    
    func createUrl(latitude:Double,longitude:Double){
        let url = URL(string: "https://api.open-meteo.com/v1/forecast?latitude=\(latitude.description)&longitude=\(longitude.description)&daily=weathercode,temperature_2m_max,temperature_2m_min,windspeed_10m_max&current_weather=true&timezone=auto&start_date=2022-11-24&end_date=2022-11-24")!
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response,error in
            guard let data = data else {return}
            
            do {
                let jsonDecoder = JSONDecoder()
                self.finalData = try jsonDecoder.decode(WheatherData.self, from: data)
                
                DispatchQueue.main.async { [weak self] in
                    self?.dataUpload()
                }
  
            } catch let error {
                print(error)
            }
            
        }
        task.resume()

    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.first {
            createUrl(latitude:location.coordinate.latitude, longitude:location.coordinate.longitude)
        }
    }
}


