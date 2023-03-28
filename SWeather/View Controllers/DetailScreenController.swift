//
//  SecondScreen.swift
//  SWeather
//
//  Created by Marcel Mravec on 24.03.2023.
//

import UIKit

class DetailScreenController: UIViewController {
    
    var selectedLocation: LocationModel?
    var weatherManager = WeatherManager()
    var mobLink = ""
    
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var apparentTemperature: UILabel!
    @IBOutlet weak var humanDecriptionLabel: UILabel!
    
    @IBOutlet weak var precipitationTypeLabel: UILabel!
    @IBOutlet weak var visibilityLabel: UILabel!
    
   @IBAction func buttonPressed(_ sender: UIButton) {
       if let url = URL(string: mobLink) {
            UIApplication.shared.open(url)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Temp details for: \(selectedLocation?.name ?? "Unknown location")"
        cityName.text = selectedLocation?.name
        print(selectedLocation)
        weatherManager.delegate = self
        weatherManager.fetchWeather(cityKey: String(selectedLocation?.key ?? 1))
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension DetailScreenController: WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        DispatchQueue.main.async {
            print(weather)
            self.countryLabel.text = self.selectedLocation?.country 
            self.tempLabel.text = String(weather.temperature)
            self.mobLink = weather.mobileLink
            self.apparentTemperature.text = String(weather.apparentTemperature)
            self.visibilityLabel.text = String(weather.visibility)
            self.humanDecriptionLabel.text = weather.weatherText
            self.precipitationTypeLabel.text = weather.precipitationType ?? "Neither raining nor snowing."
            let image = UIImage(named: "\(String(format: "%02d", weather.weatherIcon))-s.png")
            self.weatherIcon.image = image
        }
    }
    
    func didFailedWithError(error: Error) {
        print("Error of update weather....")
        print(error.localizedDescription)
    }
    
    
}
