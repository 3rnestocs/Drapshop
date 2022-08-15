//
//  HomePresenter.swift
//  Drapshop
//
//  Created by Ernesto Jose Contreras Lopez on 14/8/22.
//

import Foundation

protocol HomePresenterDelegate: AnyObject {
    func fetchProductsSucceeded()
    func fetchProductsFailed(_ message: String)
}

class HomePresenter {
    weak var viewController: HomePresenterDelegate?
    private var products: [Product]?
    private var searchedProducts: [Product] = []
    private var isSearching: Bool = false
    
    func fetchCatalogue() {
        NetworkManager.shared.request(ProductResponse.self) { result in
            switch result {
            case .success(let response):
                self.products = response.products
                self.viewController?.fetchProductsSucceeded()
            case .failure(let error):
                self.viewController?.fetchProductsFailed(error.localizedDescription)
            }
        }
    }
    
    func getProducts() -> [Product] {
        guard let products = products else {
            return []
        }
        return isSearching ? searchedProducts : products
    }
    
    func searchProduct(by query: String) {
        guard let searched = products?.filter({
            guard let name = $0.name else { return false }
            return name.localizedCaseInsensitiveContains(query)
        }) else {
            return
        }
        
        updateSearchStatus(searched, status: !query.isEmpty)
    }
    
    private func updateSearchStatus(_ searched: [Product], status: Bool) {
        isSearching = status
        searchedProducts = searched
    }
}
