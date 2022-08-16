//
//  MapViewController.swift
//  Drapshop
//
//  Created by Ernesto Jose Contreras Lopez on 15/8/22.
//

import UIKit
import MapKit

class MapViewController: DSViewController {

    // MARK: - Constant
    static let identifier = String(describing: MapViewController.self)
    
    // MARK: - Outlets
    @IBOutlet private(set) weak var homeButton: UIButton!
    @IBOutlet private(set) weak var mapView: MKMapView!
    
    // MARK: - Properties
    private var locations: [CLLocationCoordinate2D] {
        let locations = [
            CLLocationCoordinate2D(latitude: 45.412027, longitude: -75.679392),
            CLLocationCoordinate2D(latitude: 45.425160, longitude: -75.683113),
            CLLocationCoordinate2D(latitude: 45.425719, longitude: -75.738767),
            CLLocationCoordinate2D(latitude: 45.356573, longitude: -75.692460)
        ]
        return locations
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeButton.layer.cornerRadius = homeButton.frame.height / 2
    }
    
    // MARK: - Setup
    override func viewControllerTheme() -> DSViewController.NavigationStyle {
        .hidden
    }
    
    private func setup() {
        setupUI()
    }
    
    private func setupUI() {
        setupMap()
        homeButton.backgroundColor = .systemYellow
    }
    
    private func setupMap() {
        mapView.delegate = self
        let canadaLocation = CLLocationCoordinate2D(latitude: 45.412459, longitude: -75.693928)
        let camera = MKMapCamera(lookingAtCenter: canadaLocation, fromDistance: 30000, pitch: 0, heading: 0)
        mapView.setCamera(camera, animated: false)
        mapView.register(CustomAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        setupShops()
    }

    // MARK: - Helpers
    private func setupShops() {
        for (index, location) in locations.enumerated() {
            let annotation = CustomAnnotation()
            annotation.pinCustomImage = UIImage(named: "shop")
            annotation.coordinate = location
            annotation.title = "Tienda \(index)"
            mapView.addAnnotation(annotation)
        }
    }
    
    // MARK: - Actions
    @IBAction private func homeButtonTapped(_ sender: UIButton) {
        SceneSelector.shared.setHomeScene()
    }
    
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let annotation = view.annotation else { return }
        let camera = MKMapCamera(lookingAtCenter: annotation.coordinate, fromDistance: 1000, pitch: 0, heading: 0)
        mapView.setCamera(camera, animated: true)
    }
}
