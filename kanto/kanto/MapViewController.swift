//
//  MapViewController.swift
//  kanto
//
//  Created by George Tevosov on 15.02.2022.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController,UITabBarControllerDelegate, MKMapViewDelegate, CLLocationManagerDelegate {
    
    var currentPin: Pin?
    var locationManager = CLLocationManager()
    private var currentLocation: CLLocation? = nil
    private var allAnnotations: [MKAnnotation] = []
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        addPins()
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        zoomToPin(ix: 2)
    }
    
    private func addPins() {
        for (ix, _) in locationData.enumerated() {
            mapView.addAnnotation(locationData[ix])
        }
    }
    
    private func zoomToPin(ix: Int) {
        let pin = locationData[ix]
        var zoomRect = MKMapRect.null
        let annotationPoint = MKMapPoint(pin.coordinate)
        let pointRect = MKMapRect(x: annotationPoint.x, y: annotationPoint.y, width: 1, height: 1);
        zoomRect = zoomRect.union(pointRect);
        self.mapView.setVisibleMapRect(zoomRect, edgePadding: UIEdgeInsets(top: 500, left: 500, bottom: 500, right: 500), animated: true)
    }
    
    @IBAction func changeMapType(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            self.mapView.mapType = .standard
        case 1:
            self.mapView.mapType = .satellite
        case 2:
            self.mapView.mapType = .hybrid
        default:
            break;
        }  //Switch
    }
    
    @IBAction func locateMe(_ sender: UIButton) {
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.distanceFilter = 10
            locationManager.startUpdatingLocation()
        }
        if currentLocation != nil {
            let center = CLLocationCoordinate2D(latitude: currentLocation!.coordinate.latitude, longitude: currentLocation!.coordinate.longitude)
            let mRegion = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            self.mapView.setRegion(mRegion, animated: true)
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        defer { currentLocation = locations.last }
        self.mapView.showsUserLocation = true
        if currentLocation == nil {
            if let userLocation = locations.last {
                let viewRegion = MKCoordinateRegion(center: userLocation.coordinate, latitudinalMeters: 2000, longitudinalMeters: 2000)
                mapView.setRegion(viewRegion, animated: false)
            }
        }
    }
    
    func showPin(pinNum: Int) {
        self.tabBarController?.selectedIndex = 0
        zoomToPin(ix: pinNum)
        print(pinNum)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "")
        
        switch annotation.title!! {
        case locationData[0].title:
            annotationView.markerTintColor = UIColor(red: (255.0/255), green: (95.0/255), blue: (170.0/255), alpha: 1.0)
            annotationView.glyphImage = UIImage(named: "park")
        default:
            annotationView.markerTintColor = UIColor.green
        }
        return annotationView
    }
}
