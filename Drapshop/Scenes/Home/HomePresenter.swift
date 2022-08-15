//
//  HomePresenter.swift
//  Drapshop
//
//  Created by Ernesto Jose Contreras Lopez on 14/8/22.
//

import Foundation

protocol HomePresenterDelegate: AnyObject {
    func fetchImagesSucceeded()
    func fetchImagesFailed(_ message: String)
}

class HomePresenter {
    weak var viewController: HomePresenterDelegate?
    var catalogue: [Image]?
    
    func fetchCatalogue() {
        NetworkManager.shared.request([Image].self) { result in
            switch result {
            case .success(let images):
                self.catalogue = images
                self.viewController?.fetchImagesSucceeded()
            case .failure(let error):
                self.viewController?.fetchImagesFailed(error.localizedDescription)
            }
        }
    }
    
    func getCatalogue() -> [Image] {
        guard let catalogue = catalogue else {
            return []
        }
        return catalogue
    }
}
