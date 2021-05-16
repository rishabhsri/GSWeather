//
//  WeatherTableViewController.swift
//  GSWeatherAssignment
//
//  Created by Rishabh on 16/05/21.
//

import UIKit

class WeatherTableViewController: UITableViewController {
    
    private var weatherListViewModel = WeatherListViewModel()
    weak var weatherDelegate: WeatherSelectionProtocol?
    private var weatherCellReuseIdentifier = "weatherTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherListViewModel.createDataSource()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return weatherListViewModel.weatherDataList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: weatherCellReuseIdentifier, for: indexPath)
        if let weatherCell = cell as? WeatherTableViewCell {
            let weatherArray = weatherListViewModel.weatherDataList
            let weatherModel = weatherArray[indexPath.row]
            weatherCell.cityNameLabel.text = weatherModel.cityName
            weatherCell.tempratureLabel.text = weatherModel.temperature
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let weatherArray = weatherListViewModel.weatherDataList
        weatherDelegate?.citySelected(model: weatherArray[indexPath.row])
        self.dismiss(animated: true, completion: nil)
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let weatherArray = weatherListViewModel.weatherDataList
            weatherListViewModel.deleteWeather(for: weatherArray[indexPath.row])
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
}
