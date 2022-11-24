//
//  WeatherData.swift
//  WeatherApp
//
//  Created by Даша Волошина on 24.11.22.
//
//{"latitude":53.875,
//    "longitude":27.5625,
//    "generationtime_ms":1.4480352401733398,
//    "utc_offset_seconds":10800,
//    "timezone":"Europe/Minsk"
//    ,"timezone_abbreviation":"+03",
//    "elevation":203.0,
//    "current_weather":
//        {"temperature":-3.0,
//            "windspeed":8.3,
//            "winddirection":56.0,
//            "weathercode":71,
//            "time":"2022-11-24T22:00"},
//    "daily_units":
//    {"time":"iso8601",
//        "weathercode":"wmo code",
//        "temperature_2m_max":"°C",
//        "temperature_2m_min":"°C",
//        "windspeed_10m_max":"km/h"},
//    "daily":
//    {"time":["2022-11-24"],
//        "weathercode":[71],
//        "temperature_2m_max":[-2.9],
//        "temperature_2m_min":[-4.0],
//        "windspeed_10m_max":[13.7]}}

import Foundation
 
struct WheatherData: Decodable {
    
    var longitude:Double = 0.0
    var latitude:Double = 0.0
    var daily = Daily()
    var timezone:String = ""
    var current_weather = CurrentWeather()
    var daily_units = Units()
    
    init(){}
}

struct Units:Decodable {
    
    var temperature_2m_max:String = ""
    
    var windspeed_10m_max:String = ""
}

struct CurrentWeather:Decodable {
    
    var temperature: Double = 0.0
    var windspeed: Double = 0.0
}

struct Daily:Decodable {
    
    var temperature_2m_max:[Double] = [0]
    var temperature_2m_min:[Double] = [0]
    var windspeed_10m_max:[Double] = [0]
}
