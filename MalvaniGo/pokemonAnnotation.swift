//
//  pokemonAnnotation.swift
//  MalvaniGo
//
//  Created by admin on 06/04/17.
//  Copyright © 2017 ACE. All rights reserved.
//

import UIKit
import MapKit

class pokemonAnnotation: NSObject, MKAnnotation {
    
    var coordinate = CLLocationCoordinate2D()
    var pokemon : Pokemon
    
    init(coordinate : CLLocationCoordinate2D,
         pokemon : Pokemon){
        self.coordinate = coordinate
        self.pokemon = pokemon
    }
}
