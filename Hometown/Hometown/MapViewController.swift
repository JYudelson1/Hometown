//
//  MapViewController.swift
//  Hometown
//
//  Created by Joseph Yudelson on 5/17/18.
//  Copyright © 2018 Joseph Yudelson. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
import Foundation

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    var feedItems: NSArray = NSArray()
    var locationManager:CLLocationManager!
    var homeModel = HomeModel()
    var begin:Bool = true
    var terribleInfo = String()
    var terribleCat = Int()
    var terribleUser = String()
    var terriblePlace = String()
    //var locations = NSMutableArray()
    @IBOutlet weak var mapView: MKMapView!
 

    override func viewDidLoad() {
        //homeModel.downloadItems()
        
        super.viewDidLoad()
        self.mapView.delegate = self
        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create and Add MapView to our main view
        createMapView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        determineCurrentLocation()
    }
    
    func createMapView()
    {
        //mapView = MKMapView()

       // let leftMargin: CGFloat = 10
       // let topMargin: CGFloat = 60
       // let mapWidth: CGFloat = view.frame.size.width-20
       // let mapHeight: CGFloat = 300
        
        mapView.frame = CGRect(x:0,y:0,width:view.bounds.width,height:(view.bounds.height-88))
        
        mapView.mapType = MKMapType.standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        
        // Or, if needed, we can position map in the center of the view
        mapView.center = view.center
        
        view.addSubview(mapView)
        //print(GlobalVariables.sharedManager.test!)
        //print(GlobalVariables.sharedManager.locations)
        addPOIs()
        
    }
        func addPOIsTest(){
            
            for loc:LocationModel in ([LocationModel(Username:"jyudelson",Latitude:"40.8910",Longitude:"-74.0129",DateTime:"2018-05-14 21:34:38",PlaceName:"Home",Info:"This is literally my house",Category:"4",Public:"1")]){
        
                let myAnnotation:MKPointAnnotation = MKPointAnnotation()
                myAnnotation.coordinate = CLLocationCoordinate2DMake(Double(loc.Latitude!)!, Double(loc.Longitude!)!);
        myAnnotation.title = loc.PlaceName
        myAnnotation.subtitle = loc.Username
        //myAnnotation.markerTintColor = UIColor.blue
                if (loc.Public! == "1" || GlobalVariables.sharedManager.username == loc.Username!){
                    //print(loc.Public!)
                mapView.addAnnotation(myAnnotation)
                }
        }
    }
    func addPOIs(){
        class newAnnotation:MKPointAnnotation{
            var fullLocation: LocationModel
            var pinTintColor: UIColor
            override var description : String {
                return fullLocation.Category!
            }
            override var debugDescription : String {
                return fullLocation.Info!
            }
            init(fullLocation: LocationModel, pinTintColor: UIColor) {
                self.fullLocation = fullLocation
                self.pinTintColor = pinTintColor
                super.init()
            }
        }
        for loc:LocationModel in (GlobalVariables.sharedManager.locations) {
            //var annotations: MKPinAnnotationView = MKPinAnnotationView()
            let color:UIColor = UIColor.darkGray
            let myAnnotation = newAnnotation(fullLocation: loc, pinTintColor:color)
            myAnnotation.coordinate = CLLocationCoordinate2DMake(Double(loc.Latitude!)!, Double(loc.Longitude!)!);
            myAnnotation.title = loc.PlaceName
            myAnnotation.subtitle = loc.Username
            //print (myAnnotation.description)
            //myAnnotation.markerTintColor = UIColor.blue
            //annotations.add
             if (loc.Public! == "1" || GlobalVariables.sharedManager.username == loc.Username!){
            mapView.addAnnotation(myAnnotation)
            }
        }
    }
    func determineCurrentLocation()
    {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            //locationManager.startUpdatingHeading()
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation
        
        // Call stopUpdatingLocation() to stop listening for location updates,
        // other wise this function will be called every time when user location changes.
        //manager.stopUpdatingLocation()
        
        let center = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
        
        if begin{
        mapView.setRegion(region, animated: false)
        begin = false
        }
        // Drop a pin at user's Current Location
        //let myAnnotation: MKPointAnnotation = MKPointAnnotation()
        //myAnnotation.coordinate = CLLocationCoordinate2DMake(userLocation.coordinate.latitude, userLocation.coordinate.longitude);
        //myAnnotation.title = "Current location"
        //mapView.addAnnotation(myAnnotation)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Error \(error)")
    }
    
    // MARK: - Navigation

     @IBAction func clickTag(_ sender: Any) {
        GlobalVariables.sharedManager.currentLoc = mapView.userLocation.coordinate
        //print (mapView.userLocation.coordinate)
     }
    
     // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toInfo" {
            if let destination = segue.destination as? InfoViewController {
                destination.terribleInfo = terribleInfo
                destination.Category = ["None/Other", "Sights", "Hidden Spot", "Cool Minutiae", "Personal", "Stores/Business"][terribleCat]
                destination.Place = terriblePlace
                destination.User = terribleUser
                
            }
        }
    }
    

}
extension MapViewController
{
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?
    {
        if (annotation.coordinate.latitude == mapView.userLocation.coordinate.latitude && annotation.coordinate.longitude == mapView.userLocation.coordinate.longitude){ return nil}
        let annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "annotationView")
        annotationView.canShowCallout = true
        annotationView.rightCalloutAccessoryView = UIButton.init(type: UIButtonType.detailDisclosure)
        let colors = [UIColor.lightGray, UIColor.yellow, UIColor.blue, UIColor.red, UIColor.cyan, UIColor.green]
        let catColor = colors[Int(annotation.description)!]
        annotationView.pinTintColor = catColor
        //print (annotation.debugDescription!)
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl)
    {
        //GlobalVariables.sharedManager.currentInfo = view.annotation.debugDescription
        let anny = view.annotation!
        terriblePlace = anny.title!!
        terribleUser = anny.subtitle!!
        terribleInfo = anny.debugDescription!
        terribleCat = Int(anny.description)!
        //print (annotation.debugDescription!)
        performSegue(withIdentifier: "toInfo", sender: self)

    }
    
}
