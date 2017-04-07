//
//  ViewController.swift
//  MalvaniGo
//
//  Created by admin on 06/04/17.
//  Copyright © 2017 ACE. All rights reserved.
//

import UIKit
import MapKit
class ViewController: UIViewController, CLLocationManagerDelegate ,MKMapViewDelegate{
    var pokemon : [Pokemon] = []
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBAction func relocateUserOnPress(_ sender: AnyObject) {
        let region = MKCoordinateRegionMakeWithDistance(self.manager.location!.coordinate, 400, 400)
        self.mapView.setRegion(region, animated: true)
    }
    var update = 0
    //initializing manager
    var manager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.manager.delegate = self
        self.mapView.delegate = self
        self.manager.startUpdatingLocation()
        
        pokemon = bringAllPokemon() // bring all pokemonn from coredata
        
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse{
                self.mapView.showsUserLocation = true //shows user location
                self.manager.startUpdatingLocation()  //Updates the location
            
                Timer.scheduledTimer(withTimeInterval: 4, repeats: true, block:
                    {
                    (timer) in
                        if let coordinate = self.manager.location?.coordinate {
                            let randomPokemon = Int(arc4random_uniform(UInt32(self.pokemon.count)))
                            
                            let pokemon = self.pokemon[randomPokemon]
                            
                            let annotation = pokemonAnnotation(coordinate: coordinate, pokemon: pokemon)
                            annotation.coordinate = coordinate
                            annotation.coordinate.latitude += (Double(arc4random_uniform(1000))
                                - 500) / 300000.0
                            annotation.coordinate.longitude += (Double(arc4random_uniform(1000))
                                - 500) / 300000.0
                            self.mapView.addAnnotation(annotation)
                            
                        }}
            )
        }
        else{
            self.manager.requestWhenInUseAuthorization()
        }
    }
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: nil)
        if annotation is MKUserLocation {
            annotationView.image = #imageLiteral(resourceName: "player")
        }
        else{
            let pokemon = (annotation as! pokemonAnnotation).pokemon
            annotationView.image = UIImage(named: pokemon.imageFileName!)
        }
        var newFrame = annotationView.frame
        newFrame.size.width = 50
        newFrame.size.height = 50
        annotationView.frame = newFrame
        
        return annotationView
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if update < 4{  //To stop location update every second
            //Add region to load in map
            let region = MKCoordinateRegionMakeWithDistance(self.manager.location!.coordinate, 400, 400)
            self.mapView.setRegion(region, animated: true)
            update+=1
        }
        else{
            self.manager.startUpdatingLocation()
        }
    }
    
    //Go to animation on click
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        mapView.deselectAnnotation(view.annotation!, animated: true)
        
        if view.annotation! is MKUserLocation {
            return
        }
        //Takes to the annoatations vicinity
        let region = MKCoordinateRegionMakeWithDistance((view.annotation?.coordinate)!, 150,150)
        self.mapView.setRegion(region, animated: true)
        
        //
        if let coordinate = self.manager.location?.coordinate {
            if MKMapRectContainsPoint(mapView.visibleMapRect, MKMapPointForCoordinate(coordinate)){
                print("in range")
            }
            else{
                print("out of range")
            }
        }
    }
    
    //TO hide the status bar
    
    override var prefersStatusBarHidden: Bool{
        return true
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

