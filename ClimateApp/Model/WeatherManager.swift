

import Foundation
import CoreLocation
protocol WeatherManagerDelegate
{
    func didupdateWeather(_ weatherManager:WeatherManager,weather:DataToFetch)
    func didFailWithError(error:Error)
}

struct WeatherManager
{
    let weatherUrl="https://api.openweathermap.org/data/2.5/weather?appid=cc80072e528ce1b1d8bf9f34f627898d&units=metric"
    var delegate:WeatherManagerDelegate?
    
    func fetchWeather(cityName:String)
    {
        let urlString="\(weatherUrl)&q=\(cityName)"
        
        performRequest(with: urlString)
    }
    
    func fetchWeather(latitude:CLLocationDegrees,lnogitude:CLLocationDegrees)
    {
        let urlString="\(weatherUrl)&lat=\(latitude)&lon=\(lnogitude)"
        
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString:String)
    {
        //Networking//
        //1. Create a URL
        if let url = URL(string:urlString)
        {
            
            //2. Create a URL Session
            
            let session=URLSession(configuration: .default)
            //3. Give The task
            
            //            let task=session.dataTask(with: url,completionHandler: handle(data:response:error:))
            
            let task=session.dataTask(with: url) { data, response, error in
                if(error != nil)
                {
                    delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData=data
                {
                    if let weather=parseJSON(safeData)
                    {
                        delegate?.didupdateWeather(self,weather: weather)
                    }
                }
            }
            //4. Start the task
            task.resume()
        }
    }
    
    func parseJSON(_ weatherData:Data) -> DataToFetch?
    {
        let decoder=JSONDecoder()
        do
        {
            let decodedData=try decoder.decode(WeatherData.self, from: weatherData)
            
            
            let id=decodedData.weather[0].id
            let cityName=decodedData.name
            let descriPtion=decodedData.weather[0].description
            let temprature=decodedData.main.temp
            
            let weather=DataToFetch(conditionInt: id, descriptionOfForcast: descriPtion, cityName: cityName, temprature: temprature)
            return weather
        }
        catch
        {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
