//
//  DSButton.swift
//  TestPracticoAgence
//
//  Created by Ernesto Jose Contreras Lopez on 21/5/22.
//

import UIKit

class DSButton: UIButton {

    // MARK: - Style
    enum Style {
        case simple
        case login
        case register
        case forgotPassword
        case send
    }

    // MARK: - Properties
    private var activityIndicator: UIActivityIndicatorView!
    private var originalButtonText: String?

    var style: Style = .simple {
        didSet {
            setStyle()
        }
    }

    // MARK: - Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.height / 2
    }

    // MARK: - Setup
    private func initialize() {
        backgroundColor = UIColor(named: "mainWhite")
        layer.masksToBounds = false
        clipsToBounds = true
        titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        setTitleColor(.darkGray, for: .normal)
    }

    // MARK: - Private
    private func setStyle() {
        switch style {
        case .simple:
            setTitleColor(.black, for: .normal)
            backgroundColor = .systemYellow.withAlphaComponent(0.7)
        case .login, .register, .send:
            var title: String!
            switch style {
            case .login:
                title = "Entrar"
            case .register:
                title = "Registrarse"
            case .send:
                title = "Enviar"
            default:
                break
            }
            setTitle(title, for: .normal)
            setTitleColor(.systemYellow, for: .normal)
            backgroundColor = .black.withAlphaComponent(0.7)
        case .forgotPassword:
            backgroundColor = .clear
            setTitle("¿Olvidaste tu contraseña?", for: .normal)
            underLineText()
        }
    }
}

// MARK: - ActivityIndicator
extension DSButton {
    func showLoading() {
        originalButtonText = self.titleLabel?.text
        self.setTitle("", for: .normal)

        if activityIndicator == nil {
            activityIndicator = createActivityIndicator()
        }

        showSpinning()
    }

    func hideLoading() {
        self.setTitle(originalButtonText, for: .normal)
        activityIndicator.stopAnimating()
        self.isUserInteractionEnabled = true
    }

    private func createActivityIndicator() -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .black
        return activityIndicator
    }

    private func showSpinning() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(activityIndicator)
        centerActivityIndicatorInButton()
        activityIndicator.startAnimating()
        self.isUserInteractionEnabled = false
    }

    private func centerActivityIndicatorInButton() {
        let xCenterConstraint = NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: activityIndicator, attribute: .centerX, multiplier: 1, constant: 0)
        self.addConstraint(xCenterConstraint)

        let yCenterConstraint = NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: activityIndicator, attribute: .centerY, multiplier: 1, constant: 0)
        self.addConstraint(yCenterConstraint)
    }

    private func underLineText() {
        guard let title = title(for: .normal) else { return }

        let titleString = NSMutableAttributedString(string: title)
        titleString.addAttribute(
            .underlineStyle,
            value: NSUnderlineStyle.single.rawValue,
            range: NSRange(location: 0, length: title.count)
        )
        setAttributedTitle(titleString, for: .normal)
    }
}
