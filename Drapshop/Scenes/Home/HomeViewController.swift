//
//  HomeViewController.swift
//  Drapshop
//
//  Created by Ernesto Jose Contreras Lopez on 13/8/22.
//

import UIKit

class HomeViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var searchView: DSTextFieldView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Properties
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    // MARK: - Setup
    private func setup() {
        self.setupUI()
    }
    
    private func setupUI() {
        
    }
    
    // MARK: - Helpers
    
    // MARK: - Actions
}
