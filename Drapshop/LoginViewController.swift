//
//  LoginViewController.swift
//  Drapshop
//
//  Created by Ernesto Jose Contreras Lopez on 12/8/22.
//

import UIKit

class LoginViewController: UIViewController {

    // MARK: - Constants
    @IBOutlet private(set) weak var scrollView: UIScrollView!
    @IBOutlet private(set) weak var logoImageView: UIImageView!
    @IBOutlet private(set) weak var registrateButton: DSButton!
    @IBOutlet private(set) weak var usuarioView: DSTextFieldView!
    @IBOutlet private(set) weak var claveView: DSTextFieldView!
    @IBOutlet private(set) weak var entrarButton: DSButton!
    @IBOutlet private(set) weak var olvidarButton: DSButton!
    
    // MARK: - Properties
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        logoImageView.layer.cornerRadius = logoImageView.frame.height / 2
    }
    
    // MARK: - Setup
    private func setup() {
        setupUI()
        setupObserver()
    }

    private func setupObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func setupUI() {
        setupButtons()
        setupTextFieldViews()
    }
    
    private func setupButtons() {
        registrateButton.style = .register
        entrarButton.style = .login
        olvidarButton.style = .forgotPassword
    }
    
    private func setupTextFieldViews() {
        usuarioView.textType = .username
        claveView.textType = .password
    }
    
    // MARK: - Helpers
    
    // MARK: - Actions
    @IBAction private func registrarseButtonTapped(_ sender: DSButton) {
        
    }
    
    @IBAction private func entrarButtonTapped(_ sender: DSButton) {
        
    }
    
    @IBAction private func olvidarButtonTapped(_ sender: DSButton) {
        
    }
    
    @objc private func keyboardWillShow(notification:NSNotification) {
        guard let keyboardSize = (
            notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
        )?.cgRectValue else {
            return
        }
        
        addScrollViewInset(keyboardSize.height + 80)
    }

    @objc private func keyboardWillHide(notification:NSNotification) {
        addScrollViewInset()
    }
    
    private func addScrollViewInset(_ inset: CGFloat = 0.0) {
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: inset, right: 0.0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets

        UIView.animate(withDuration: 0.3) { [unowned self] in
              self.view.layoutIfNeeded()
          }
    }
}

