//
//  AddViewController.swift
//  MyProperty
//
//  Created by jeewan bhusal on 3.8.2020.
//  Copyright © 2020 MyProperty. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation // For user location updates

//handleMapSearch protocol declared
protocol HandleMapSearch {
    func dropPinZoomIn(placemark:MKPlacemark)
}

class AddViewController: UIViewController, CLLocationManagerDelegate{
    
    //variable for location address
    var address :String = ""
    //variable defined for placemark which will be received from MapSearch Controller
    var selectedPin:MKPlacemark? = nil
   
    //variable stores CLLocation library, which helps to get user's current location
    let locationManager = CLLocationManager()
    var myLocation:CLLocationCoordinate2D = CLLocationCoordinate2D.init(latitude: 0, longitude: 0)
    
    //trying to implement search functionality in map
    var resultSearchController:UISearchController? = nil
    
    
    //Outlets
    //Map View Outlet
    @IBOutlet weak var MapView: MKMapView!
    //Local textfields in the AddviewController where properties adding form is displayed
    @IBOutlet weak var houseTypeField: UITextField!
    @IBOutlet weak var contact: UITextField!
    @IBOutlet weak var describe: UITextField!
    @IBOutlet weak var price: UITextField!
    @IBOutlet weak var location: UITextField!
    
    
    //Local variables of array for appending the data of textfields
    var houseArray: [String] = []
    var contactArray: [String] = []
    var priceArray: [String] = []
    var locationArray: [String] = []
    var describeArray: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
        //methods for starting the map
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        //referencing MapSearchController class to locationSearchTable variable
        let locationSearchTable = storyboard!.instantiateViewController(withIdentifier: "MapSearchController") as! MapSearchController
        resultSearchController = UISearchController(searchResultsController: locationSearchTable)
        resultSearchController?.searchResultsUpdater = locationSearchTable as UISearchResultsUpdating
        
        locationSearchTable.handleMapSearchDelegate = self
        
        //adding search bar to MapSearchController's view
        let searchBar = resultSearchController!.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "Search for places"
        navigationItem.titleView = resultSearchController?.searchBar
        
        resultSearchController?.hidesNavigationBarDuringPresentation = false
        resultSearchController?.obscuresBackgroundDuringPresentation = true
        definesPresentationContext = true
        
        //Assinging mapview received from MapSearchController to local MapView
        locationSearchTable.mapView = MapView
        
    }
    
    
    //button for signing out
    @IBAction func signOutAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    //button for adding property to the local arrays
    @IBAction func AddPropertyAction(_ sender: UIButton) {
        let houseVal = houseTypeField.text!
        let contactVal = contact.text!
        let priceVal = price.text!
        let locationVal = location.text!
        let describeVal = describe.text!
        
        //condition check if the textfields are empty or not , if not empty the texts are added to the array
        if (!houseVal.isEmpty && !contactVal.isEmpty && !priceVal.isEmpty && !locationVal.isEmpty && !describeVal.isEmpty){
                //appending text from textfields to arrays
                houseArray.append(houseVal)
                contactArray.append(contactVal)
                priceArray.append(priceVal)
                locationArray.append(locationVal)
                describeArray.append(describeVal)
                
                //way of informing user that the property was added.
                let alert = UIAlertController(title: "Success", message: "Property has been added", preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    } else {
                        let alert = UIAlertController(title: "Input Error", message: "Fields Cannot Be Empty", preferredStyle: UIAlertController.Style.alert)
                        
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
        
        print("HouseArray:::\(houseArray)")
               
    }
    
    //after the view appearing again, the initially filled values in the textfield will be made empty
    override func viewWillAppear(_ animated: Bool) {
        houseTypeField.text! = ""
        contact.text! = ""
        price.text! = ""
        location.text! = ""
        describe.text! = ""
    }
    
    
    //button for navigating to propertyView controller
    @IBAction func propertyAction(_ sender: UIButton) {
        performSegue(withIdentifier: "segueToProperty", sender: self)
    }
    
    //Segue for passing data from this controller to PropertyViewController
     //Which displays the values of array in table view cell
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //var vc = segue.destination as! PropertyViewController
        
        let vc = segue.destination as! PropertyViewController
        
        vc.houseArr.append(contentsOf: houseArray)
        vc.contactArr.append(contentsOf: contactArray)
        vc.describeArr.append(contentsOf: describeArray)
        vc.locationArr.append(contentsOf: locationArray)
        vc.priceArr.append(contentsOf: priceArray)
        
    }
    
    
    
    //function for finding the location of the user in the map
    func locationManager(_ locationManager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.first
       
        let locationSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        myLocation = CLLocationCoordinate2DMake((location?.coordinate.latitude)!,(location?.coordinate.longitude)!)
        let locationRegion = MKCoordinateRegion(center: myLocation, span: locationSpan)
        MapView.setRegion(locationRegion, animated: true)
    }
    
}
    
    //the placemark of the typed address from the user is received from the MapSearchController and assigned to selectedPin variable
    extension AddViewController: HandleMapSearch {
    func dropPinZoomIn(placemark:MKPlacemark){
        // cache the pin
        selectedPin = placemark
        // clear existing pins
        MapView.removeAnnotations(MapView.annotations)
        let annotation = MKPointAnnotation()
        annotation.coordinate = placemark.coordinate
        annotation.title = placemark.name
        if let _ = placemark.locality,
            let _ = placemark.administrativeArea {
            annotation.subtitle = "(city) (state)"
        }
        MapView.addAnnotation(annotation)
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: placemark.coordinate, span: span)
        MapView.setRegion(region, animated: true)
        
        //adding the address from the search into the address texfield in the view
        location.text = placemark.name
    }
}

