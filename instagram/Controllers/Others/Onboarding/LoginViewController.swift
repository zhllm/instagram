//
//  LoginViewController.swift
//  instagram
//
//  Created by 张杰 on 2020/12/16.
//
import SafariServices
import UIKit
import SnapKit

class LoginViewController: UIViewController {
    
    struct Constants {
        static let cornerRadius: CGFloat = 8.0
    }
    
    private let usernameTextField: UITextField = {
        let textFiled = UITextField()
        textFiled.placeholder = "Username Or Email...."
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
    
    private let passwordTextField: UITextField = {
        let textFiled = UITextField()
        textFiled.placeholder = "Password...."
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
    
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log in", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Constants.cornerRadius
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    private let termsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Terms of Servicd", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        return button
    }()
    
    private let privacyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Privacy Policy", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        return button
    }()
    
    private let createAccountButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.label, for: .normal)
        button.setTitle("New User? Craete an Account", for: .normal)
        return button
    }()
    
    private let headerView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        let backgroundImageView = UIImageView(image: UIImage(named: "gradient"))
        view.addSubview(backgroundImageView)
        backgroundImageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        let text = UIImageView(image: UIImage(named: "text"))
        view.addSubview(text)
        text.snp.makeConstraints { (make) in
            make.centerY.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.5)
            make.height.equalTo(60)
        }
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.addTarget(self,
                              action: #selector(didTapLoginButton),
                              for: .touchUpInside)
        createAccountButton.addTarget(self,
                              action: #selector(didTapCreateAccountButton),
                              for: .touchUpInside)
        termsButton.addTarget(self,
                              action: #selector(didTapTermsButton),
                              for: .touchUpInside)
        privacyButton.addTarget(self,
                              action: #selector(didTapPrivacyButton),
                              for: .touchUpInside)
        
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        
        addsubviews()
        
        self.view.backgroundColor = .systemBackground
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // assign frame
        headerView.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            // self.view.safeAreaInsets.top
            make.top.equalTo(0.0)
            make.height.equalTo(view.height / 3)
        }
        
        usernameTextField.frame = CGRect(
            x: 25,
            y: headerView.bottom + 40,
            width: view.width - 50,
            height: 52.0
        )
        
        passwordTextField.frame = CGRect(
            x: 25,
            y: usernameTextField.bottom + 10,
            width: view.width - 50,
            height: 52.0
        )
        
        loginButton.frame = CGRect(
            x: 25,
            y: passwordTextField.bottom + 10,
            width: view.width - 50,
            height: 52.0
        )
        
        createAccountButton.frame = CGRect(
            x: 25,
            y: loginButton.bottom + 10,
            width: view.width - 50,
            height: 52.0
        )
        
        termsButton.frame = CGRect(
            x: 10,
            y: view.height - view.safeAreaInsets.bottom - 100,
            width: view.width - 20,
            height: 50.0
        )
        
        privacyButton.frame = CGRect(
            x: 10,
            y: view.height - view.safeAreaInsets.bottom - 50,
            width: view.width - 20,
            height: 50.0
        )
        
        configureHeadervView()
    }
    
    func configureHeadervView() {
        guard headerView.subviews.count == 1 else {
            return
        }
        
        // Add instagram Logo
        guard let backgroundView = headerView.subviews.first  else {
            return
        }
        backgroundView.frame = headerView.bounds
        let imageView = UIImageView(image: UIImage(named: "text"))
        headerView.addSubview(imageView)
        imageView.contentMode = .scaleAspectFit
        imageView.snp.makeConstraints { (make) in
            make.centerX.centerY.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.5)
        }
        
    }
    
    func addsubviews() {
        self.view.addSubview(usernameTextField)
        self.view.addSubview(passwordTextField)
        self.view.addSubview(loginButton)
        self.view.addSubview(termsButton)
        self.view.addSubview(privacyButton)
        self.view.addSubview(createAccountButton)
        self.view.addSubview(headerView)
        
    }
    
    @objc private func didTapLoginButton() {
        usernameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        guard let usernameEmail = usernameTextField.text, !usernameEmail.isEmpty,
              let password = passwordTextField.text, password.count >= 8 else {
            return
        }
        
        var username: String?
        var email: String?
        
        if usernameEmail.contains("@"), usernameEmail.contains(".") {
            // email
            email = usernameEmail
        } else {
            // username
            username = usernameEmail
        }
        
        // login function
        AuthManager.shared.loginUser(username: username, email: email, password: password) { (sucess) in
            DispatchQueue.main.async {
                if sucess {
                    self.dismiss(animated: true, completion: nil)
                } else {
                    let alert = UIAlertController(title: "Log in Error",
                                                  message: "We are unable log you in.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Dismis",
                                                  style: .cancel,
                                                  handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    @objc private func didTapTermsButton() {
        guard let url = URL(string: "https://www.instagram.com/about/legal/terms/before-january-19-2013/") else {
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
    @objc private func didTapPrivacyButton() {
        guard let url = URL(string: "https://help.instagram.com/519522125107875") else {
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
    @objc private func didTapCreateAccountButton() {
        let vc = RegistrationViewController()
        vc.title = "Create an Account"
        present(UINavigationController(rootViewController: vc), animated: true) 
    }
    
    
}

// MARK: - UITextViewDelegate
extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            didTapLoginButton()
        }
        return true
    }
}
