//
//  ViewController.swift
//  Running
//
//  Created by Djuro Alfirevic on 4/21/17.
//  Copyright © 2017 Sistemi. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet weak var mapView: MKMapView!
    var items = [RunningPoint]()
    var polyline = MKPolyline()
    var locationManager: CLLocationManager!
    var locations = [
        CLLocation(latitude: 44.824613, longitude: 20.412065),
        CLLocation(latitude: 44.824887, longitude: 20.411464),
        CLLocation(latitude: 44.825724, longitude: 20.409501),
        CLLocation(latitude: 44.825435, longitude: 20.408203),
        CLLocation(latitude: 44.824575, longitude: 20.407409),
        CLLocation(latitude: 44.823844, longitude: 20.406787),
        CLLocation(latitude: 44.822954, longitude: 20.406884),
        CLLocation(latitude: 44.822193, longitude: 20.408558),
        CLLocation(latitude: 44.821607, longitude: 20.409760),
        CLLocation(latitude: 44.821965, longitude: 20.411037),
        CLLocation(latitude: 44.823611, longitude: 20.412412)
    ]
    var counter = 0
    var timer: Timer?

    // MARK: - Actions
    @IBAction func testOverlayButtonTapped() {
        clearMap()
        items.removeAll()

        items.append(RunningPoint(location: CLLocation(latitude: 44.824613, longitude: 20.412065)))
        items.append(RunningPoint(location: CLLocation(latitude: 44.824887, longitude: 20.411464)))
        items.append(RunningPoint(location: CLLocation(latitude: 44.825724, longitude: 20.409501)))
        items.append(RunningPoint(location: CLLocation(latitude: 44.825435, longitude: 20.408203)))
        items.append(RunningPoint(location: CLLocation(latitude: 44.824575, longitude: 20.407409)))
        items.append(RunningPoint(location: CLLocation(latitude: 44.823844, longitude: 20.406787)))
        items.append(RunningPoint(location: CLLocation(latitude: 44.822954, longitude: 20.406884)))
        items.append(RunningPoint(location: CLLocation(latitude: 44.822193, longitude: 20.408558)))
        items.append(RunningPoint(location: CLLocation(latitude: 44.821607, longitude: 20.409760)))
        items.append(RunningPoint(location: CLLocation(latitude: 44.821965, longitude: 20.411037)))
        items.append(RunningPoint(location: CLLocation(latitude: 44.823611, longitude: 20.412412)))

        mapView.addAnnotations(items)

        if let point = items.last {
            zoomToPoint(point)
        }
        
        drawPolyline()
    }

    @IBAction func simulationButtonTapped() {
        clearMap()
        items.removeAll()

        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(timerTick), userInfo: nil, repeats: true)
    }

    @IBAction func overlayButtonTapped() {
        clearMap()
        items.removeAll()

        mapView.addAnnotations(items)

        if let point = items.last {
            zoomToPoint(point)
        }

        drawPolyline()
    }

    // MARK: - Public API
    func timerTick() {
        clearMap()

        if counter < locations.count {
            let location = locations[counter]
            items.append(RunningPoint(location: location))
        } else {
            if let timer = timer {
                timer.invalidate()
                counter = 0
            }
        }

        if let point = items.last {
            zoomToPoint(point)
        }

        drawPolyline()

        counter = counter + 1
    }

    // MARK: - Private API
    fileprivate func configureLocationManager() {
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.distanceFilter = 10.0 // In meters.
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    fileprivate func zoomToPoint(_ point: RunningPoint) {
        let span = MKCoordinateSpan(latitudeDelta: 0.015, longitudeDelta: 0.015)
        let region = MKCoordinateRegion(center: point.coordinate, span: span)
        mapView.setRegion(region, animated: true)
    }

    fileprivate func clearMap() {
        mapView.removeAnnotations(items)
        mapView.remove(polyline)
    }

    fileprivate func drawPolyline() {
        if items.isEmpty {
            return
        }

        let coordinates = locationCoordinates()
        polyline = MKPolyline(coordinates: coordinates, count: coordinates.count)
        mapView.add(polyline)
    }

    fileprivate func locationCoordinates() -> [CLLocationCoordinate2D] {
        var coords = [CLLocationCoordinate2D]()

        for point in items {
            coords.append(point.coordinate)
        }

        return coords
    }

    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureLocationManager()
    }

}

extension ViewController: CLLocationManagerDelegate {

    // MARK: - CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location manager error: \(error.localizedDescription)")
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            print("Location: (\(location.coordinate.latitude), \(location.coordinate.longitude))")
            items.append(RunningPoint(location: location))
        }
    }

}

extension ViewController: MKMapViewDelegate {

    // MARK: - MKMapViewDelegate
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(polyline: polyline)
        renderer.strokeColor = UIColor.red
        renderer.lineWidth = 5.0

        return renderer
    }

}
