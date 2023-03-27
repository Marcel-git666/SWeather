//
//  SearchScreen.swift
//  SWeather
//
//  Created by Marcel Mravec on 24.03.2023.
//

import UIKit
import CoreLocation

class SearchScreenController: UITableViewController {
  
    var currentLocationManager = CLLocationManager()
    var locationManager = LocationManager()
    
    var cities = [LocationModel]()
//    let brno = LocationModel(key: 1, name: "Brno")
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = UIColor.darkGray
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
                navigationItem.standardAppearance = appearance
                navigationItem.scrollEdgeAppearance = appearance
        title = "Weather - search for locations"
        
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "location.circle.fill"), for: .normal)
        button.addTarget(self, action: #selector(locationButtonPressed), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 53, height: 51)
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = barButton
        
        currentLocationManager.delegate = self
        currentLocationManager.requestWhenInUseAuthorization()
        currentLocationManager.requestLocation()
        
        locationManager.delegate = self
        //cities.append(brno)
    }
    
    @objc func locationButtonPressed() {

           print("Showing current location")
    }
    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return cities.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath)
        cell.textLabel?.text = cities[indexPath.row].name + String(cities[indexPath.row].key)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection
                                section: Int) -> String? {
       return "Search weather in some interesting place"
    }
    
    // MARK: - Navigation
    
     override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         performSegue(withIdentifier: K.segue, sender: self)
     }
     
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         let destinationVC = segue.destination as! DetailScreenController
         if let indexPath = tableView.indexPathForSelectedRow {
             destinationVC.selectedCity = cities[indexPath.row].name
         }
     }

    

}

//MARK: - SearchBar methods

extension SearchScreenController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let loc = searchBar.text {
            locationManager.fetchLocations(autocompleteSearch: loc)
        }
        
        searchBar.text = ""
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
            
        }
    }
}


//MARK: - CLLocationManagerDelegate

extension SearchScreenController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        if let location = locations.last {
            currentLocationManager.stopUpdatingLocation()
//            let lat = String(location.coordinate.latitude)
//            let lon = String(location.coordinate.longitude)
//            weatherManager.fetchWeather(latitude: lat, longitude: lon)
  //      }
        
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error of current location manager")
        print(error.localizedDescription)
    }
}


//MARK: - LocationManagerDelegate

extension SearchScreenController: LocationManagerDelegate {
    func didUpdateLocation(_ locationManager: LocationManager, location: [LocationModel]) {
        print("Updating locations...")
        cities = location
        print(cities)
        print("Locations updated.")
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    
    func didFailedWithError(error: Error) {
        print("Error of update locations....")
        print(error.localizedDescription)
    }
}
