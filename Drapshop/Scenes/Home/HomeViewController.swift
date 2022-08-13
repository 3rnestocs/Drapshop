//
//  HomeViewController.swift
//  Drapshop
//
//  Created by Ernesto Jose Contreras Lopez on 13/8/22.
//

import UIKit

class HomeViewController: DSViewController {
    
    // MARK: - Constant
    static let identifier = String(describing: HomeViewController.self)

    // MARK: - Outlets
    @IBOutlet weak var salirButton: UIButton!
    @IBOutlet weak var searchView: DSTextFieldView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Properties
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        salirButton.layer.cornerRadius = salirButton.frame.height / 2
    }
    
    // MARK: - Setup
    private func setup() {
        self.setupUI()
    }
    
    private func setupUI() {
        salirButton.backgroundColor = .systemYellow
        searchView.textType = .defaultType
    }
    
    // MARK: - Helpers
    
    // MARK: - Actions
    @IBAction private func salirButtonTapped(_ sender: UIButton) {
        SceneSelector.shared.setInitialSCene()
    }
}
