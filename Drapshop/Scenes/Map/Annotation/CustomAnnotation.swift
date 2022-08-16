//
//  CustomAnnotation.swift
//  Drapshop
//
//  Created by Ernesto Jose Contreras Lopez on 15/8/22.
//

import MapKit

class CustomAnnotation: MKPointAnnotation {
    var pinCustomImage: UIImage!
}

class CustomAnnotationView: MKAnnotationView {
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        canShowCallout = true
        update(for: annotation)
    }

    override var annotation: MKAnnotation? {
        didSet {
            update(for: annotation)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func update(for annotation: MKAnnotation?) {
        image = (annotation as? CustomAnnotation)?.pinCustomImage
    }
}
