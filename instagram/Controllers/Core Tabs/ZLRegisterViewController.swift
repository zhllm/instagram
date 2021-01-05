//
//  ZLRegisterViewController.swift
//  instagram
//
//  Created by 张杰 on 2020/12/28.
//

import UIKit
import SnapKit

class ZLRegisterViewController: UIViewController {
    
    lazy private var mainTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.customFont(family: .MontserratMedium, size: 23)
        label.textColor = .secondaryLabel
        label.text = "Sign up"
        return label
    }()
    
    lazy private var fullNameTextFied: UITextField = {
        let field = UITextField()
        field.placeholder = "Full name"
        // field.borderStyle = .roundedRect
        field.clearButtonMode = .whileEditing
        field.keyboardType = .namePhonePad
        field.returnKeyType = .next
        field.textColor = .label
        field.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1)
        field.layer.cornerRadius = 6
        field.layer.masksToBounds = true
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 0))
        return field
    }()
    
    lazy private var emailTextFied: UITextField = {
        let field = UITextField()
        field.placeholder = "Email"
        // field.borderStyle = .roundedRect
        field.clearButtonMode = .whileEditing
        field.keyboardType = .namePhonePad
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
        field.keyboardType = .namePhonePad
        field.returnKeyType = .next
        field.textColor = .label
        field.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1)
        field.layer.cornerRadius = 6
        field.layer.masksToBounds = true
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 0))
        return field
    }()
    
    
    lazy private var createAccountButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 0.16, green: 0.4, blue: 1, alpha: 1)
        button.layer.cornerRadius = 6
        button.layer.masksToBounds = true
        button.setTitle("Create an account", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.customFont(family: .MontserratMedium, size: 18)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    //
    
    lazy private var tips: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.customFont(family: .MontserratMedium, size: 16)
        label.textColor = .secondaryLabel
        label.text = " By signing up you agree to our"
        return label
    }()
    
    lazy private var waringTips: ZLCustomView = {
        let tips = ZLCustomView()
        return tips
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
    
    private lazy var bottomsignUpButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1)
        button.layer.cornerRadius = 6
        button.layer.masksToBounds = true
        button.setTitle("I have an account", for: .normal)
        button.titleLabel?.font = UIFont.customFont(family: .MontserratSemiBold, size: 16)
        button.setTitleColor(.secondaryLabel, for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "info.circle"),
            style: .done,
            target: self,
            action: #selector(didTapRightBarButton)
        )
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "chevron.backward"),
            style: .plain,
            target: self,
            action: #selector(didTapBackButton))
        
        configureUI()
    }
    
    func configureUI() {
        view.addSubview(mainTitle)
        mainTitle.snp.makeConstraints { (make) in
            make.top.equalTo(ZL_naviBarHeight + 50) // .offset(50)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        view.addSubview(fullNameTextFied)
        fullNameTextFied.snp.makeConstraints { (make) in
            make.top.equalTo(mainTitle.snp.bottom).offset(49)
            make.width.equalToSuperview().inset(40)
            make.height.equalTo(44)
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(emailTextFied)
        emailTextFied.snp.makeConstraints { (make) in
            make.top.equalTo(fullNameTextFied.snp.bottom).offset(15)
            make.width.equalToSuperview().inset(40)
            make.height.equalTo(44)
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(passwordTextFied)
        passwordTextFied.snp.makeConstraints { (make) in
            make.top.equalTo(emailTextFied.snp.bottom).offset(15)
            make.width.equalToSuperview().inset(40)
            make.height.equalTo(44)
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(createAccountButton)
        createAccountButton.snp.makeConstraints { (make) in
            make.top.equalTo(passwordTextFied.snp.bottom).offset(15)
            make.left.right.width.height.equalTo(passwordTextFied)
        }
        
        view.addSubview(tips)
        tips.snp.makeConstraints { (make) in
            make.top.equalTo(createAccountButton.snp.bottom).offset(20)
            make.width.equalToSuperview()
        }
        view.addSubview(waringTips)
        waringTips.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.height.equalTo(30)
            make.top.equalTo(tips.snp.bottom)
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        waringTips.setContent()
    }
    
    
    
    @objc func didTapRightBarButton() {
        
    }
    
    @objc func didTapBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func didTapBottomSignupButton() {
        
    }
}
