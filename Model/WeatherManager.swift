
import Foundation


import Foundation
import CoreLocation

protocol WeatherManagerDelegate{
    func didUpdateWeather(_ weatherManager: WeatherManager , weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=cc40a23e0af3c90c1d6f6ffa3e3cf0b6&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String){
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(urlString: urlString)
    }
    
    func fetchWeatherWithLatLong(Latitude: CLLocationDegrees, longtitude: CLLocationDegrees){
        let urlStringNew = "\(weatherURL)&lat=\(Latitude)&lon=\(longtitude)"
        performRequest(urlString: urlStringNew)
    }
    
    func performRequest(urlString: String)
    {
        //1.create URL
        if let url = URL(string: urlString)
        {
            //2. create URL session
        
        let session = URLSession(configuration: .default)
        //3. give session a task
            let task = session.dataTask(with: url) { (data, response, error) in
                    if error != nil
                    {
                        self.delegate?.didFailWithError(error: error!)
                        return
                        }
                
                
                if let safeData = data {
                    if let weather = self.parseJSON(weatherData: safeData){
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                        }
            }
        //start the task
        task.resume()
                                           
        }
    }
    func parseJSON(weatherData: Data) -> WeatherModel?{
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = (decodedData.weather[0].id)
            let temp = (decodedData.main.temp)
            let name = (decodedData.name)
            
            let weather = WeatherModel(conditionId: id, temperature: temp, cityName: name)
            return weather
        } catch{
            delegate?.didFailWithError(error: error)
            return nil
                }
        }
    
}
