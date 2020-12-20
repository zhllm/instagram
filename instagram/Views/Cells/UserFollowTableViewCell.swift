//
//  UserFollowTableViewCell.swift
//  instagram
//
//  Created by 张杰 on 2020/12/19.
//

import UIKit

protocol UserFollowTableViewCellDelegate: AnyObject {
    func didTapFollowButton(model: UserRelationship)
}

enum FollowState {
    case following // indicates the current user is following the other user
    case not_following
}

struct UserRelationship {
    let username: String
    let name: String
    let type: FollowState
}

class UserFollowTableViewCell: UITableViewCell {
    static let identifier = "UserFollowTableViewCell"
    
    public weak var delegate: UserFollowTableViewCellDelegate?
    
    private var model: UserRelationship?
    
    private let profileImageView: UIImageView = {
        let imview = UIImageView()
        imview.contentMode = .scaleAspectFill
        imview.layer.masksToBounds = true
        imview.backgroundColor = .secondarySystemFill
        return imview
    }()
    
    private let nameLable: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.text = "@name"
        return label
    }()
    
    private let usernameLable: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.text = "@joe"
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .secondaryLabel
        return label
    }()
    
    private let followButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .link
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(nameLable)
        contentView.addSubview(usernameLable)
        contentView.addSubview(profileImageView)
        contentView.addSubview(followButton)
        selectionStyle = .none
        followButton.addTarget(self, action: #selector(didTapFollowButton), for: .touchUpInside)
    }
    
    @objc func didTapFollowButton() {
        guard let model = model else {
            return
        }
        self.delegate?.didTapFollowButton(model: model)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        profileImageView.image = nil
        nameLable.text = nil
        usernameLable.text = nil
        followButton.setTitle(nil, for: .normal)
        followButton.layer.borderWidth = 0
        followButton.backgroundColor = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        profileImageView.frame = CGRect(x: 3,
                                        y: 3,
                                        width: contentView.height - 6,
                                        height: contentView.height - 6)
        profileImageView.layer.cornerRadius = profileImageView.height / 2
        
        let buttonWidth = contentView.width > 500 ? 220.0 : contentView.width / 3
        followButton.frame = CGRect(x: contentView.width - 5 - buttonWidth,
                                    y: (contentView.height - 40) / 2,
                                    width: buttonWidth,
                                    height: 40)
        
        let labelHeight = contentView.height / 2
        nameLable.frame = CGRect(x: profileImageView.right + 5,
                                 y: 0,
                                 width: contentView.width - 8 - profileImageView.width - buttonWidth,
                                 height: labelHeight)
        usernameLable.frame = CGRect(x: profileImageView.right + 5,
                                     y: nameLable.bottom,
                                     width: contentView.width - 8 - profileImageView.width - buttonWidth,
                                     height: labelHeight)
    }
    
    public func configure(with model: UserRelationship) {
        self.model = model
        nameLable.text = model.name
        usernameLable.text = model.username
        switch model.type {
        case .following:
            // show unfollow button
            followButton.setTitle("unfollow", for: .normal)
            followButton.setTitleColor(.label, for: .normal)
            followButton.backgroundColor = .systemBackground
            followButton.layer.borderWidth = 1
            followButton.layer.borderColor = UIColor.label.cgColor
        case .not_following:
            // show follow button
            followButton.setTitle("follow", for: .normal)
            followButton.setTitleColor(.white, for: .normal)
            followButton.backgroundColor = .link
            followButton.layer.borderWidth = 0
        }
    }
}
