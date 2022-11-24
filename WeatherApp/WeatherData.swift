//
//  WeatherData.swift
//  WeatherApp
//
//  Created by Даша Волошина on 24.11.22.
//

import Foundation

struct WeatherData: Decodable {
    let latitude, longitude, generationtimeMS: Double
    let utcOffsetSeconds: Int
    let timezone, timezoneAbbreviation: String
    let elevation: Int
    let dailyUnits: DailyUnits
    let daily: Daily

    enum CodingKeys: String, CodingKey {
        case latitude, longitude
        case generationtimeMS = "generationtime_ms"
        case utcOffsetSeconds = "utc_offset_seconds"
        case timezone
        case timezoneAbbreviation = "timezone_abbreviation"
        case elevation
        case dailyUnits = "daily_units"
        case daily
    }
}

// MARK: - Daily
struct Daily: Decodable {
    let time: [String]
    let temperature2MMax: [Double]
    let temperature2MMin, windspeed10MMax: [Int]

    enum CodingKeys: String, CodingKey {
        case time
        case temperature2MMax = "temperature_2m_max"
        case temperature2MMin = "temperature_2m_min"
        case windspeed10MMax = "windspeed_10m_max"
    }
}

// MARK: - DailyUnits
struct DailyUnits: Decodable {
    let time, temperature2MMax, temperature2MMin, windspeed10MMax: String

    enum CodingKeys: String, CodingKey {
        case time
        case temperature2MMax = "temperature_2m_max"
        case temperature2MMin = "temperature_2m_min"
        case windspeed10MMax = "windspeed_10m_max"
    }
}
