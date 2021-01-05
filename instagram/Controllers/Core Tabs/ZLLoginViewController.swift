//
//  ZLLoginViewController.swift
//  instagram
//
//  Created by 张杰 on 2020/12/28.
//

import UIKit
import SnapKit

class ZLLoginViewController: UIViewController {
    
    lazy private var titleimageIcon: UIView = {
        let imageView = UIView()
        // imageView.layer.masksToBounds = true
        return imageView
    }()
    
    lazy private var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = UIFont.customFont(family: .MontserratMedium, size: 24)
        label.text = "SECTOR"
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()
    
    lazy private var subLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.customFont(family: .AvenirBook, size: 16)
        label.text = "news"
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()
    
    lazy private var emailTextFied: UITextField = {
        let field = UITextField()
        field.placeholder = "Email"
        // field.borderStyle = .roundedRect
        field.clearButtonMode = .whileEditing
        field.keyboardType = .emailAddress
        field.returnKeyType = .next
        field.textColor = .label
        field.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1)
        field.layer.cornerRadius = 6
        field.layer.masksToBounds = true
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 0))
        return field
    }()
    
    lazy private var passwordTextFied: UITextField = {
        let field = UITextField()
        field.placeholder = "Password"
        // field.borderStyle = .roundedRect
        field.clearButtonMode = .whileEditing
        field.keyboardType = .emailAddress
        field.returnKeyType = .next
        field.textColor = .label
        field.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1)
        field.layer.cornerRadius = 6
        field.layer.masksToBounds = true
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 0))
        return field
    }()
    
    lazy private var btnContainer: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy private var signUpButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 0.18, green: 0.18, blue: 0.18, alpha: 1)
        button.layer.cornerRadius = 6
        button.layer.masksToBounds = true
        button.setTitle("Sign up", for: .normal)
        button.titleLabel?.font = UIFont.customFont(family: .MontserratSemiBold, size: 16)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    lazy private var signInButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 0.16, green: 0.4, blue: 1, alpha: 1)
        button.layer.cornerRadius = 6
        button.layer.masksToBounds = true
        button.setTitle("Sign in", for: .normal)
        button.titleLabel?.font = UIFont.customFont(family: .MontserratSemiBold, size: 16)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    private lazy var forgetLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.customFont(family: .AvenirBook, size: 15)
        label.textColor = UIColor(red: 0.16, green: 0.4, blue: 1, alpha: 1)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "Fogot password?"
        return label
    }()
    
    private lazy var bottomsignUpButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1)
        button.layer.cornerRadius = 6
        button.layer.masksToBounds = true
        button.setTitle("Sign in", for: .normal)
        button.titleLabel?.font = UIFont.customFont(family: .MontserratSemiBold, size: 16)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    private lazy var facebookButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1).cgColor
        button.layer.cornerRadius = 6
        button.layer.masksToBounds = true
        button.setImage(UIImage(named: "Icon"), for: .normal)
        return button
    }()
    
    private lazy var googleButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1).cgColor
        button.layer.cornerRadius = 6
        button.layer.masksToBounds = true
        button.setImage(UIImage(named: "google"), for: .normal)
        return button
    }()
    
    private lazy var twritterButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1).cgColor
        button.layer.cornerRadius = 6
        button.layer.masksToBounds = true
        button.setImage(UIImage(named: "twritter"), for: .normal)
        return button
    }()
    
    private lazy var signTipsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.customFont(family: .AvenirBook, size: 15)
        label.textColor = .label
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "Or sign in with social networks"
        return label
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configUI()
    }
    
    func configUI() {
        titleimageIcon.frame = CGRect(
            x: view.width / 2 - 38,
            y: ZL_naviBarHeight + 40,
            width: 76,
            height: 76
        )
        titleimageIcon.layer.shadowOpacity = 1
        titleimageIcon.layer.shadowRadius = 10
        titleimageIcon.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        titleimageIcon.layer.shadowColor = UIColor(red: 0.11,
                                                   green: 0.11,
                                                   blue: 0.11,
                                                   alpha: 0.15).cgColor
        titleimageIcon.layer.shadowOffset = CGSize(width: 0, height: 5)
        titleimageIcon.layer.cornerRadius = titleimageIcon.bounds.size.width / 2;
        view.addSubview(titleimageIcon)
        // titleimageIcon.image = UIImage(named: "Logo")
        let titleIcon = UIImageView(image: UIImage(named: "Logo"))
        view.addSubview(titleIcon)
        titleIcon.frame =  CGRect(
            x: view.width / 2 - 18,
            y: ZL_naviBarHeight + 53,
            width: 36,
            height: 48
        )
        view.addSubview(titleIcon)
        titleIcon.layer.masksToBounds = true
        titleIcon.contentMode = .scaleAspectFill
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleimageIcon.snp.bottom).offset(15)
        }
        
        view.addSubview(subLabel)
        subLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom)
        }
        
        view.addSubview(emailTextFied)
        emailTextFied.snp.makeConstraints { (make) in
            make.top.equalTo(subLabel.snp.bottom).offset(49)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().inset(40)
            make.height.equalTo(44)
        }
        emailTextFied.delegate = self
        
        // passwordTextFied
        view.addSubview(passwordTextFied)
        passwordTextFied.snp.makeConstraints { (make) in
            make.top.equalTo(emailTextFied.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().inset(40)
            make.height.equalTo(44)
        }
        passwordTextFied.delegate = self
        
        
        view.addSubview(signUpButton)
        print(btnContainer.top)
        signUpButton.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(44)
            make.top.equalTo(passwordTextFied.snp.bottom).offset(15)
            make.height.equalTo(44)
            make.width.equalTo((view.width - 15 - 80) / 2)
        }
        
        view.addSubview(signInButton)
        signInButton.snp.makeConstraints { (make) in
            make.top.equalTo(signUpButton.snp.top)
            make.right.equalToSuperview().offset(-40)
            make.width.equalTo(signUpButton.snp.width)
            make.height.equalTo(signUpButton.snp.height)
        }
        
        view.addSubview(forgetLabel)
        forgetLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(signUpButton.snp.bottom).offset(20)
        }
        
        view.addSubview(bottomsignUpButton)
        bottomsignUpButton.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-ZL_bottomTabBarSpacing - 20)
            make.width.equalToSuperview().inset(40)
            make.height.equalTo(44)
            make.left.equalToSuperview().offset(40)
        }
        bottomsignUpButton.addTarget(self,
                                     action: #selector(didTapBottomSignupButton),
                                     for: .touchUpInside)
        
        view.addSubview(facebookButton)
        facebookButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(bottomsignUpButton.snp.top).offset(-40)
            make.left.equalTo(40)
            make.width.equalTo((view.width - 80 - 30 ) / 3)
            make.height.equalTo(44)
        }
        
        view.addSubview(googleButton)
        googleButton.snp.makeConstraints { (make) in
            make.left.equalTo(facebookButton.snp.right).offset(15)
            make.top.equalTo(facebookButton.snp.top)
            make.width.equalTo(facebookButton.snp.width)
            make.height.equalTo(44)
        }
        
        view.addSubview(twritterButton)
        twritterButton.snp.makeConstraints { (make) in
            make.left.equalTo(googleButton.snp.right).offset(15)
            make.top.equalTo(googleButton.snp.top)
            make.width.equalTo(googleButton.snp.width)
            make.height.equalTo(44)
        }
        
        view.addSubview(signTipsLabel)
        signTipsLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(twritterButton.snp.top).offset(-20)
            make.centerX.equalToSuperview()
        }
        
    }
    
    @objc func didTapBottomSignupButton() {
        let vc = ZLRegisterViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


extension ZLLoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if textField == emailTextFied {
            passwordTextFied.becomeFirstResponder()
        } else if textField == passwordTextFied {
            print("hello world")
        }
        return true
    }
}
