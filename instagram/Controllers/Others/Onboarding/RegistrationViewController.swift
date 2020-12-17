//
//  RegistrationViewController.swift
//  instagram
//
//  Created by 张杰 on 2020/12/16.
//

import UIKit

class RegistrationViewController: UIViewController {
    
    struct Constants {
        static let cornerRadius: CGFloat = 8.0
    }
    
    private let usernameField: UITextField = {
        let textFiled = UITextField()
        textFiled.placeholder = "Username...."
        textFiled.returnKeyType = .next
        textFiled.leftViewMode = .always
        textFiled.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textFiled.autocapitalizationType = .none
        textFiled.autocorrectionType = .no
        textFiled.layer.masksToBounds = true
        textFiled.layer.cornerRadius = Constants.cornerRadius
        textFiled.backgroundColor = .secondarySystemBackground
        textFiled.layer.borderWidth = 1.0
        textFiled.layer.borderColor = UIColor.secondaryLabel.cgColor
        return textFiled
    }()
    
    private let emailField: UITextField = {
        let textFiled = UITextField()
        textFiled.placeholder = "Email Address...."
        textFiled.returnKeyType = .continue
        textFiled.leftViewMode = .always
        textFiled.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textFiled.autocapitalizationType = .none
        textFiled.autocorrectionType = .no
        textFiled.layer.masksToBounds = true
        textFiled.layer.cornerRadius = Constants.cornerRadius
        textFiled.backgroundColor = .secondarySystemBackground
        textFiled.layer.borderWidth = 1.0
        textFiled.layer.borderColor = UIColor.secondaryLabel.cgColor
        return textFiled
    }()
    
    private let passwordField: UITextField = {
        let textFiled = UITextField()
        textFiled.placeholder = "password...."
        textFiled.returnKeyType = .next
        textFiled.leftViewMode = .always
        textFiled.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textFiled.autocapitalizationType = .none
        textFiled.autocorrectionType = .no
        textFiled.layer.masksToBounds = true
        textFiled.layer.cornerRadius = Constants.cornerRadius
        textFiled.backgroundColor = .secondarySystemBackground
        textFiled.layer.borderWidth = 1.0
        textFiled.layer.borderColor = UIColor.secondaryLabel.cgColor
        return textFiled
    }()
    
    
    private let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign up", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Constants.cornerRadius
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        registerButton.addTarget(self, action: #selector(didTapRegister), for: .touchUpInside)
        view.addSubview(usernameField)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(registerButton)
        usernameField.delegate = self
        emailField.delegate = self
        passwordField.delegate = self
        self.view.backgroundColor = .systemBackground
    }
    
    override func viewDidLayoutSubviews() {
        usernameField.frame = CGRect(x: 20, y: view.safeAreaInsets.top + 100, width: view.width - 40, height: 52)
        emailField.frame = CGRect(x: 20, y: usernameField.bottom + 10, width: view.width - 40, height: 52)
        passwordField.frame = CGRect(x: 20, y: emailField.bottom + 10, width: view.width - 40, height: 52)
        registerButton.frame = CGRect(x: 20, y: passwordField.bottom + 10, width: view.width - 40, height: 52)
        
    }
    
    @objc func didTapRegister() {
        passwordField.resignFirstResponder()
        usernameField.resignFirstResponder()
        emailField.resignFirstResponder()
        guard let username = usernameField.text, !username.isEmpty,
              let password = passwordField.text, !password.isEmpty, password.count >= 8,
              let email = emailField.text, !email.isEmpty else {
            return
        }
        print("\(password) \(username) \(email)")
        AuthManager.shared.registerUser(username: username, email: email, password: password) { (success) in
            DispatchQueue.main.async {
                if success {
                    
                } else {
                    
                }
            }
        }
        
    }
    
}

extension RegistrationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameField {
            emailField.becomeFirstResponder()
        } else if textField == emailField {
            passwordField.becomeFirstResponder()
        } else {
            didTapRegister()
        }
        return true
    }
}
