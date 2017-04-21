//
//  RunningPoint.swift
//  Running
//
//  Created by Djuro Alfirevic on 4/21/17.
//  Copyright © 2017 Sistemi. All rights reserved.
//

import Foundation
import MapKit

class RunningPoint: NSObject {

    // MARK: - Properties
    var location: CLLocation

    // MARK: - Public API
    func mapPoint() -> MKMapPoint {
        return MKMapPointForCoordinate(location.coordinate)
    }

    // MARK: - Initializer
    init(location: CLLocation) {
        self.location = location
    }

}

extension RunningPoint: MKAnnotation {

    // MARK: - MKAnnotation
    var title: String? {
        return "(\(location.coordinate.latitude), \(location.coordinate.longitude))"
    }

    var coordinate: CLLocationCoordinate2D {
        return location.coordinate
    }

}
