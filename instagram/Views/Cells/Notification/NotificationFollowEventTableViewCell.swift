//
//  NotificationFollowEventTableViewCell.swift
//  instagram
//
//  Created by 张杰 on 2020/12/19.
//

import UIKit

protocol NotificationFollowEventTableViewCellDelegate: AnyObject {
    func didTapFollowunFollowButton(model: UserNotification)
}

class NotificationFollowEventTableViewCell: UITableViewCell {
    
    static let identifier = "NotificationFollowEventTableViewCell"
    
    public weak var delegate: NotificationFollowEventTableViewCellDelegate?
    
    private var model: UserNotification?
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .label
        return imageView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 0
        label.text = "@kanyewen ... last modify"
        return label
    }()
    
    private let followButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 4.0
        button.layer.masksToBounds = true
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(profileImageView)
        contentView.addSubview(label)
        contentView.addSubview(followButton)
        followButton.addTarget(
            self,
            action: #selector(didTapFollowButton),
            for: .touchUpInside
        )
        configFollowButton()
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        followButton.setTitle(nil, for: .normal)
        followButton.backgroundColor = .none
        followButton.layer.borderWidth = 0
        label.text = nil
        profileImageView.image = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        profileImageView.frame = CGRect(x: 3, y: 3, width: contentView.height - 6, height: contentView.height - 6)
        profileImageView.layer.cornerRadius = profileImageView.height / 2
        let size: CGFloat = 100 // contentView.height - 4
        let buttonHeight: CGFloat = 40
        followButton.frame = CGRect(
            x: contentView.width - 5 - size,
            y: (contentView.height - buttonHeight) / 2,
            width: size,
            height: buttonHeight
        )
        label.frame = CGRect(x: profileImageView.right + 5,
                             y: 0,
                             width: contentView.width - size - profileImageView.width - 16,
                             height: contentView.height)
    }
    
    public func configure(with model: UserNotification) {
        self.model = model
        switch model.type {
        case .like(post: let post):
            let thumbnail = post.thumbnailImage
            guard !thumbnail.absoluteString.contains("google.com") else {
                return
            }
            followButton.sd_setBackgroundImage(with: thumbnail,
                                             for: .normal,
                                             completed: nil)
            break
        case .follow(let state):
            switch state {
            case .following:
                configFollowButton()
            case .not_following:
                followButton.setTitle("Follow", for: .normal)
                followButton.setTitleColor(.white, for: .normal)
                followButton.layer.borderWidth = 0
                followButton.backgroundColor = .link
            }
            break
        }
        label.text = model.text
        profileImageView.sd_setImage(with: model.user.profilePhoto, completed: nil)
    }
    
    private func configFollowButton() {
        followButton.setTitle("Unfollow", for: .normal)
        followButton.setTitleColor(.label, for: .normal)
        followButton.layer.borderWidth = 1
        followButton.layer.borderColor = UIColor.secondaryLabel.cgColor
    }
    
    @objc private func didTapFollowButton() {
        guard let model = model else {
            return
        }
        self.delegate?.didTapFollowunFollowButton(model: model)
    }
}
