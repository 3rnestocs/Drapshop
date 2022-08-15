//
//  SignupViewController.swift
//  Drapshop
//
//  Created by Ernesto Jose Contreras Lopez on 13/8/22.
//

import UIKit

class SignupViewController: DSViewController {

    // MARK: - Constant
    static let identifier = String(describing: SignupViewController.self)
    
    // MARK: - Outlets
    @IBOutlet private(set) weak var imageView: UIImageView!
    @IBOutlet private(set) weak var usuarioView: DSTextFieldView!
    @IBOutlet private(set) weak var claveView: DSTextFieldView!
    @IBOutlet private(set) weak var enviarButton: DSButton!
    @IBOutlet private(set) weak var usuarioWarningView: UIView!
    @IBOutlet private(set) weak var usuarioWarningLabel: UILabel!
    @IBOutlet private(set) weak var claveWarningView: UIView!
    @IBOutlet private(set) weak var claveWarningLabel: UILabel!
    
    // MARK: - Properties
    private var presenter: SignupPresenter {
        let presenter = SignupPresenter()
        return presenter
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageView.layer.cornerRadius = imageView.frame.height / 2
    }
    
    // MARK: - Setup
    private func setup() {
        self.setupUI()
    }
    
    private func setupUI() {
        setupTextfieldViews()
        setupButton()
    }
    
    private func setupTextfieldViews() {
        usuarioView.textType = .username
        claveView.textType = .password
    }
    
    private func setupButton() {
        enviarButton.style = .login
    }
    
    // MARK: - Helpers
    private func checkCredentials() -> Bool {
        var hasValidCredentials = false

        let userStatus = presenter.checkCredential(usuarioView.textField.text, type: .username)
        let passwordStatus = presenter.checkCredential(claveView.textField.text, type: .password)

        switch userStatus {
        case .empty:
            usuarioWarningLabel.text = "Debes escribir un nombre de usuario"
            usuarioWarningView.isHidden = false
            hasValidCredentials = false
        case .shortUser:
            usuarioWarningLabel.text = "El nombre de usuario debe ser de tres o más carácteres"
            usuarioWarningView.isHidden = false
            hasValidCredentials = false
        default:
            usuarioWarningView.isHidden = true
            hasValidCredentials = true
        }
        
        switch passwordStatus {
        case .empty:
            claveWarningLabel.text = "Debes escribir una contraseña"
            claveWarningView.isHidden = false
            hasValidCredentials = false
        case .shortPassword:
            claveWarningLabel.text = "La contraseña debe ser de ocho carácteres exactos"
            claveWarningView.isHidden = false
            hasValidCredentials = false
        default:
            claveWarningView.isHidden = true
            hasValidCredentials = true
        }
        return hasValidCredentials
    }
    
    private func goHomeScreen() {
        presenter.registerUser(
            password: claveView.textField.text, username: usuarioView.textField.text
        )
        SceneSelector.shared.setHomeScene()
    }
    
    // MARK: - Actions
    @IBAction private func enviarButtonTapped(_ sender: DSButton) {
        if checkCredentials() {
            goHomeScreen()
        }
    }
}
