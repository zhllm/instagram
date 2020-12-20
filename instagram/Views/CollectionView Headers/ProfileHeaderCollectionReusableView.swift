//
//  ProfileHeaderCollectionReusableView.swift
//  instagram
//
//  Created by 张杰 on 2020/12/18.
//

import UIKit

protocol ProfileHeaderCollectionReusableViewDelegate: AnyObject {
    func profileHeaderDidTapPostsButton(_ header: ProfileHeaderCollectionReusableView)
    func profileHeaderDidTapFollowerButton(_ header: ProfileHeaderCollectionReusableView)
    func profileHeaderDidTapFollowingButton(_ header: ProfileHeaderCollectionReusableView)
    func profileHeaderDidTapEditProfileButton(_ header: ProfileHeaderCollectionReusableView)
}

final class ProfileHeaderCollectionReusableView: UICollectionReusableView {
    static let identifier = "ProfileHeaderCollectionReusableView"
    
    public weak var delegate: ProfileHeaderCollectionReusableViewDelegate?
    
    private let profilePhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let postsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Posts", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .secondarySystemGroupedBackground
        return button
    }()
    
    private let followingButton: UIButton = {
        let button = UIButton()
        button.setTitle("Following", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .secondarySystemGroupedBackground
        return button
    }()
    
    private let followerButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("Follower", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .secondarySystemGroupedBackground
        return button
    }()
    
    private let editYourProfileButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.label, for: .normal)
        button.setTitle("Edit Your Profile", for: .normal)
        button.backgroundColor = .secondarySystemGroupedBackground
        return button
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .label
        label.text = "Joe Smith"
        return label
    }()
    
    private let bioLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .black
        label.text = "This is the first account"
        return label
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        clipsToBounds = true
        addSubviews()
        addButtonActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ActionEvents
    func addButtonActions() {
        postsButton.addTarget(
            self,
            action: #selector(self.profileHeaderDidTapPostsButton),
            for: .touchUpInside
        )
        
        followerButton.addTarget(
            self,
            action: #selector(self.profileHeaderDidTapFollowerButton),
            for: .touchUpInside
        )
        
        followingButton.addTarget(
            self,
            action: #selector(self.profileHeaderDidTapFollowingButton),
            for: .touchUpInside
        )
        
        editYourProfileButton.addTarget(
            self,
            action: #selector(self.profileHeaderDidTapEditProfileButton),
            for: .touchUpInside
        )
    }
    
    func addSubviews() {
        addSubview(profilePhotoImageView)
        addSubview(postsButton)
        addSubview(followerButton)
        addSubview(followingButton)
        addSubview(editYourProfileButton)
        addSubview(nameLabel)
        addSubview(bioLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let profilePhotoSize = width / 4
        profilePhotoImageView.frame = CGRect(
            x: 5,
            y: 5,
            width: profilePhotoSize,
            height: profilePhotoSize
        ).integral
        
        profilePhotoImageView.layer.cornerRadius = profilePhotoSize / 2
        
        
        let buttonHeight = profilePhotoSize / 2
        let countButtonWidth = (width - 10 - profilePhotoSize) / 3
        
        postsButton.frame = CGRect(
            x: profilePhotoImageView.right,
            y: 5,
            width: countButtonWidth,
            height: buttonHeight
        ).integral
        
        followerButton.frame = CGRect(
            x: postsButton.right,
            y: 5,
            width: countButtonWidth,
            height: buttonHeight
        ).integral
        
        followingButton.frame = CGRect(
            x: followerButton.right,
            y: 5,
            width: countButtonWidth,
            height: buttonHeight
        ).integral
        
        editYourProfileButton.frame = CGRect(
            x: profilePhotoImageView.right,
            y: 5 + buttonHeight,
            width: countButtonWidth * 3,
            height: buttonHeight
        ).integral
        
        nameLabel.frame = CGRect(
            x: 5,
            y: 5 + profilePhotoImageView.bottom,
            width: width - 10,
            height: 50
        ).integral
        
        let bioLabelSzie = sizeThatFits(self.frame.size)
        bioLabel.frame = CGRect(
            x: 5,
            y: 5 + nameLabel.bottom,
            width: width - 10,
            height: bioLabelSzie.height
        )
    }
    
    @objc func profileHeaderDidTapPostsButton() {
        self.delegate?.profileHeaderDidTapPostsButton(self)
    }
    @objc func profileHeaderDidTapFollowerButton() {
        self.delegate?.profileHeaderDidTapFollowerButton(self)
    }
    @objc func profileHeaderDidTapFollowingButton() {
        self.delegate?.profileHeaderDidTapFollowingButton(self)
    }
    @objc func profileHeaderDidTapEditProfileButton() {
        self.delegate?.profileHeaderDidTapEditProfileButton(self)
    }
}
