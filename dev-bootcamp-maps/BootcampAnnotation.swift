//
//  BootcampAnnotation.swift
//  dev-bootcamp-maps
//
//  Created by Bartosz Odrzywołek on 15/05/16.
//  Copyright © 2016 Bartosz. All rights reserved.
//

import Foundation
import MapKit

class BootcampAnnotation: NSObject, MKAnnotation {
    
    var coordinate = CLLocationCoordinate2D()
    
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
    
    
    
}
