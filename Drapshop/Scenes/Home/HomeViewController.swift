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
    @IBOutlet private(set) weak var salirButton: UIButton!
    @IBOutlet private(set) weak var searchView: DSTextFieldView!
    @IBOutlet private(set) weak var collectionView: UICollectionView!
    
    // MARK: - Properties
    lazy var presenter: HomePresenter = {
        let presenter = HomePresenter()
        presenter.viewController = self
        return presenter
    }()
    
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
        setupUI()
        requestImages()
    }
    
    private func setupUI() {
        setupCollectionView()
        salirButton.backgroundColor = .systemYellow
        searchView.textType = .defaultType
    }
    
    private func setupCollectionView() {
        collectionView.register(UINib(nibName: HomeCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: HomeCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .white
        view.backgroundColor = .white
    }
    
    // MARK: - Helpers
    private func requestImages() {
        showActivityIndicator()
        presenter.fetchCatalogue()
    }
    
    // MARK: - Actions
    @IBAction private func salirButtonTapped(_ sender: UIButton) {
        SceneSelector.shared.setLoginScene()
    }
}

extension HomeViewController: HomePresenterDelegate {
    func fetchImagesSucceeded() {
        collectionView.reloadData()
        hideActivityIndicator()
    }
    
    func fetchImagesFailed(_ message: String) {
        print("T3ST", message)
        hideActivityIndicator()
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.getCatalogue().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier, for: indexPath) as? HomeCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.setupCell(image: presenter.getCatalogue()[indexPath.row].urls.regular, name: "Product number \(indexPath.row)")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        print("T3ST", presenter.getCatalogue().count, presenter.catalogue?.count)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size: CGFloat = UIScreen.main.bounds.width / 2.4
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        24
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 24, left: 24, bottom: 24, right: 24)
    }
}
