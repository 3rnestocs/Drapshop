//
//  HomeCollectionViewCell.swift
//  Drapshop
//
//  Created by Ernesto Jose Contreras Lopez on 14/8/22.
//

import UIKit
import Kingfisher

class HomeCollectionViewCell: UICollectionViewCell {

    // MARK: - Constant
    static let identifier = String(describing: HomeCollectionViewCell.self)

    @IBOutlet private(set) weak var productNameLabel: UILabel!
    @IBOutlet private(set) weak var productImageView: UIImageView!

    func setupCell(image: String?, name: String) {
        productNameLabel.text = name
        if let image = image, let url = URL(string: image) {
            productImageView.kf.setImage(with: url)
        }
    }
}
