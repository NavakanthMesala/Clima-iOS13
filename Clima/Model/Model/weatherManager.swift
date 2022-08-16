//
//  weatherManager.swift
//  Clima
//
//  Created by Nava Kanth on 8/9/22.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation

struct weatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=cc40a23e0af3c90c1d6f6ffa3e3cf0b6"
    
    func fetchWeather(cityName: String){
        let urlString = "\(weatherURL)&q=\(cityName)"
        print(urlString)
    }
}
