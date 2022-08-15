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
    private var catalogue: [Image]?
    private var searchedCatalogue: [Image] = []
    private var isSearching: Bool = false
    
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
        return isSearching ? searchedCatalogue : catalogue
    }
    
    func searchProduct(by query: String) {
        guard let searched = catalogue?.enumerated().filter({
            return $0.element.getName($0.offset + 1).localizedCaseInsensitiveContains(query)
        }) else {
            return
        }
        
        updateSearchStatus(searched.map({$0.element}), status: !query.isEmpty)
    }
    
    private func updateSearchStatus(_ searched: [Image], status: Bool) {
        isSearching = status
        searchedCatalogue = searched
    }
}
