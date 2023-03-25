//
//  SecondScreen.swift
//  SWeather
//
//  Created by Marcel Mravec on 24.03.2023.
//

import UIKit

class SecondScreen: UIViewController {
    
    var selectedCity: String = ""
    
    @IBOutlet weak var cityName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Second Screen \(selectedCity)"
        cityName.text = selectedCity
        
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
