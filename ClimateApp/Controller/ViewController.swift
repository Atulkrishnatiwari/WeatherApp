//
//  ViewController.swift
//  ClimateApp
//
//  Created by Celestial on 01/12/23.
//

import UIKit
import CoreLocation
class ViewController: UIViewController
{
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var imageOfCloud: UIImageView!
    
    @IBOutlet weak var tempratureLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    var weatherManager=WeatherManager()
    var locationManager=CLLocationManager()
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        locationManager.delegate=self
        //it always before requestlocation method
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        weatherManager.delegate=self
        searchTextField.delegate=self
    }
    @IBAction func currentLocationPressed(_ sender: UIButton)
    {
        locationManager.requestLocation()
    }
}

//MARK: - UITextFieldDelegate

extension ViewController: UITextFieldDelegate
{
    @IBAction func searchButton(_ sender: UIButton)
    {
        searchTextField.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        searchTextField.endEditing(true)
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool
    {
        if(textField.text != "")
        {
            return true
        }
        else
        {
            textField.placeholder = "Type Something"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField)
    {
        if let city=searchTextField.text
        {
            weatherManager.fetchWeather(cityName: city)
        }
        searchTextField.text=""
    }
}

//MARK: -WeatherManagerDelegate

extension ViewController:WeatherManagerDelegate
{
    func didupdateWeather(_ weatherManager:WeatherManager,weather:DataToFetch)
    {
        DispatchQueue.main.async
        {
            self.tempratureLabel.text=weather.computedPropert
            self.imageOfCloud.image=UIImage(systemName: weather.getConditionName)
            self.descriptionLabel.text=weather.descriptionOfForcast
            self.cityLabel.text=weather.cityName
        }
    }
    
    func didFailWithError(error: Error)
    {
        print(error)
    }
}
//MARK: -CLLocationManagerDelegate

extension ViewController:CLLocationManagerDelegate
{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        if let location=locations.last
        {
            locationManager.stopUpdatingLocation()
            let lat=location.coordinate.latitude
            let longi=location.coordinate.longitude
            
            weatherManager.fetchWeather(latitude: lat,lnogitude:longi)
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print(error)
    }
}
