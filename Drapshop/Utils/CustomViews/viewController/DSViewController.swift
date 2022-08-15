//
//  DSViewController.swift
//  Drapshop
//
//  Created by Ernesto Jose Contreras Lopez on 24/6/22.
//

import Foundation
import UIKit


class DSViewController: UIViewController {
    enum NavigationStyle {
        case simple
        case hidden
    }

    // MARK: - Properties
    lazy var theme: NavigationStyle = viewControllerTheme()
    private var activityIndicatorView: UIActivityIndicatorView!
    
    // MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationStyle()
    }
    
    // MARK: - Setup
    func viewControllerTheme() -> NavigationStyle {
        .simple
    }
    
    private func setupNavigationStyle() {
        setupNavigationBar()
        
        var backImage = UIImage()

        switch theme {
        case .simple:
            navigationController?.setNavigationBarHidden(false, animated: true)
            if let image = UIImage(named: "backArrow") {
                backImage = image
            }
        case .hidden:
            navigationController?.setNavigationBarHidden(true, animated: true)
        }

        navigationController?.navigationBar.backIndicatorImage = backImage
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = backImage
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
    }
    
    private func setupNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.tintColor = .black
    }
    
    func showActivityIndicator() {
        activityIndicatorView = UIActivityIndicatorView(style: .medium)
        activityIndicatorView.tintColor = .black
        activityIndicatorView.color = .black
        let frameSize: CGPoint = CGPoint(x: UIScreen.main.bounds.size.width*0.5, y: UIScreen.main.bounds.size.height*0.5)
        activityIndicatorView?.center = frameSize
        self.view.addSubview(activityIndicatorView!)
        self.view.bringSubviewToFront(activityIndicatorView!)
        activityIndicatorView?.startAnimating()
    }

    func hideActivityIndicator() {
        if activityIndicatorView != nil {
            activityIndicatorView?.stopAnimating()
            activityIndicatorView = nil
        }
    }
}
