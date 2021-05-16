//
//  ViewController.swift
//  GSWeatherAssignment
//
//  Created by Rishabh on 14/05/21.
//

import UIKit

protocol WeatherSelectionProtocol: class {
    func citySelected(model: WeatherModel)
}

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var visibilityLabel: UILabel!
    @IBOutlet weak var sunriseLabel: UILabel!
    @IBOutlet weak var sunsetLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchWeatherLabel: UILabel!
    @IBOutlet weak var parentView: UIView!
    
    private let weatherViewModel = WeatherViewModel()
    private let showWeatherSegue = "showFavDestinations"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.searchTextField.delegate = self
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let weatherListNavController = segue.destination as? UINavigationController, let weatherListViewController = weatherListNavController.children.first as? WeatherTableViewController  {
            weatherListViewController.weatherDelegate = self
        }
    }
}

// Mark:- Extension to conform UITextFieldDelegate and implement utilities methods
extension WeatherViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if let count = textField.text?.count, count > 2 {
            getWeatherInfo(for: textField.text ?? "")
        }
        return true
    }
    
    private func getWeatherInfo(for city: String, completion: ((Bool) -> Void)? = nil) {
        if ReachabilityTest.isConnectedToNetwork() {
            weatherViewModel.getWeatherDetailsForCity(for: city, completion: {[weak self] (weatherInfo) in
                guard let self = self else { return }
                if let weatherDetail = weatherInfo {
                    self.populateData(weatherInfo: weatherDetail)
                    self.searchBar.searchTextField.text = ""
                    completion?(true)
                } else {
                    Utility.showAlert(message: "City not found. Please ensure the right name.", on: self)
                    completion?(false)
                }
            })
        } else {
            Utility.showAlert(message: "Ensure you have internet connectivity.", on: self)
            completion?(false)
        }
    }
    
    private func populateData(weatherInfo: WeatherModel) {
        self.searchWeatherLabel.isHidden = true
        self.parentView.isHidden = false
        self.cityNameLabel.text = weatherInfo.cityName
        self.tempLabel.text = weatherInfo.temperature
        self.humidityLabel.text = weatherInfo.humidity
        self.visibilityLabel.text = weatherInfo.visibility
        self.windSpeedLabel.text = weatherInfo.windSpeed
        self.sunriseLabel.text = weatherInfo.sunrise
        self.sunsetLabel.text = weatherInfo.sunset
    }
}

// Mark:- Extension to implement IBActions
extension WeatherViewController {
    
    @IBAction func showFavourite(_ sender: Any) {
        self.performSegue(withIdentifier: showWeatherSegue, sender: nil)
    }
    
    @IBAction func markFavouriteAction(_ sender: Any){
        if let weather = weatherViewModel.weatherDetail {
            WeatherInfo.storeWeatherInfo(weatherDetail: weather)
        }
    }
}

extension WeatherViewController: WeatherSelectionProtocol {
    func citySelected(model: WeatherModel) {
        if ReachabilityTest.isConnectedToNetwork() {    // Check if internet is available...
            self.getWeatherInfo(for: model.cityName, completion: {success in
                if success {
                    self.markFavouriteAction(AnyClass.self) // Update the the information in local...
                }
            })
        } else {
            populateData(weatherInfo: model)
            weatherViewModel.weatherDetail = model
        }
    }
}

