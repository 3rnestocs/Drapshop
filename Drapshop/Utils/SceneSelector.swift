//
//  SceneSelector.swift
//  Blackjack
//
//  Created by Ernesto Jose Contreras Lopez on 4/8/22.
//

import UIKit
import Foundation

class SceneSelector {
    static let shared = SceneSelector()

    func setInitialScene() {
        if UserDefaults.standard.user != nil {
            let homeVC = HomeViewController(nibName: HomeViewController.identifier, bundle: nil)
            setScene(fromViewController: homeVC)
        } else {
            let loginVC = LoginViewController(nibName: LoginViewController.identifier, bundle: nil)
            setScene(fromViewController: loginVC)
        }
    }

    func setLoginScene() {
        let loginVC = LoginViewController(nibName: LoginViewController.identifier, bundle: nil)
        setScene(fromViewController: loginVC)
    }
    
    func setHomeScene() {
        let homeVC = HomeViewController(nibName: HomeViewController.identifier, bundle: nil)
        setScene(fromViewController: homeVC)
    }

    func setScene(fromViewController viewController: UIViewController, inNavigationController showNavigationController: Bool = false) {

        let nextViewController: UIViewController

        // reset the root view controller
        if showNavigationController {
            nextViewController = UINavigationController(rootViewController: viewController)
        } else {
            nextViewController = viewController
        }

        setViewControllerInKeyWindow(nextViewController)
    }

    func setViewControllerInKeyWindow(_ viewController: UIViewController) {

        guard let window = UIApplication.shared.connectedScenes.compactMap({$0 as? UIWindowScene}).flatMap({$0.windows}).first(where: { $0.isKeyWindow }) else {
            return
        }

        // Clean up the view stack before resetting the rootViewController
        for subview in window.subviews {
            subview.removeFromSuperview()
        }

        let transition = CATransition()
        transition.duration = 1
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = .fade
        transition.fillMode = .both
        window.layer.add(transition, forKey: nil)

        window.rootViewController = viewController
    }
    
    func setWindow(_ window: UIWindow?) {
        guard let window = window else {
            return
        }

        window.makeKey()
    }
}
