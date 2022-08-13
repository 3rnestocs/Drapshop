//
//  DSTextField.swift
//  Eventbox
//
//  Created by Ernesto Jose Contreras Lopez on 8/25/21.
//

import UIKit

    // MARK: - Types
enum TextType {
    case defaultType
    case username
    case password
}

class DSTextFieldView: UIView {

    // MARK: - Outlets
    @IBOutlet private(set) weak var contentView: UIView!
    @IBOutlet private(set) weak var imageView: UIImageView!
    @IBOutlet private(set) weak var textField: UITextField!
    
    // MARK: - Properties
    var textType = TextType.defaultType {
        didSet {
            configureTypeText()
            configureView()
        }
    }

    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.height / 2
        self.contentView.layer.cornerRadius = contentView.frame.height / 2
    }

    // MARK: - Setup
    private func initialize() {
        Bundle.main.loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)
        addSubview(self.contentView)
        self.contentView.frame = self.bounds
        self.contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        self.clipsToBounds = true
    }

    private func configureTypeText() {
        switch self.textType {
        case .username:
            self.textField.keyboardType = .emailAddress
            setPlaceHolder(title: "Escribe tu usuario")
        case .password:
            self.textField.isSecureTextEntry = true
            setPlaceHolder(title: "Escribe tu contraseña")
        case .defaultType:
            self.textField.keyboardType = .default
        }
    }

    private func configureView() {
        configureStyle()
        configureImage()
    }

    private func configureStyle() {
        self.contentView.backgroundColor = .white

        self.textField.attributedPlaceholder = NSAttributedString(
            string: self.textField.placeholder ?? "",
            attributes: [
                NSAttributedString.Key.foregroundColor: UIColor.black.withAlphaComponent(0.3)
            ]
        )
        self.textField.delegate = self
        self.textField.textColor =  .darkGray
        self.textField.backgroundColor = .clear
        self.contentView.layer.borderColor = UIColor.black.withAlphaComponent(0.7).cgColor
        self.contentView.layer.borderWidth = 1.5
    }

    private func configureImage() {
        imageView.tintColor = .darkGray
        switch self.textType {
        case .username:
            imageView.image = UIImage(named: "id-card")
        case .password:
            imageView.image = UIImage(named: "lock")
        default:
            break
        }
    }

    // MARK: - Helpers
    func clearTextField() {
        self.textField.resignFirstResponder()
        self.textField.text = nil
    }

    func setPlaceHolder(title: String) {
        self.textField.placeholder = title
    }

    // MARK: - Actions
    @IBAction func iconButtonTapped(_ sender: UIButton) {
        sender.isSelected.toggle()
        switch textType {
        case .password:
            self.textField.isSecureTextEntry = !sender.isSelected
            imageView.image = sender.isSelected ? UIImage(named: "unlock") : UIImage(named: "lock")
        default:
            break
        }
    }
}

extension DSTextFieldView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.textField.resignFirstResponder()
        return true
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text,
           let textRange = Range(range, in: text),
           let updatedText = text.replacingCharacters(in: textRange,
                                                      with: string) as String? {
            if textType == .password, updatedText.count > 8 {
                return false
            }
        }
        return true
    }
}
