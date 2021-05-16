//
//  WeatherTableViewCell.swift
//  GSWeatherAssignment
//
//  Created by Rishabh on 16/05/21.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var tempratureLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
