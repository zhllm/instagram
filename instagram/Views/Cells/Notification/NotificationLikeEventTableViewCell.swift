//
//  NotificationLikeEventTableViewCell.swift
//  instagram
//
//  Created by 张杰 on 2020/12/19.
//

import UIKit
import SDWebImage

protocol NotificationLikeEventTableViewCellDelegate: AnyObject {
    func didTapRelatedPostButton(model: UserNotification)
}

class NotificationLikeEventTableViewCell: UITableViewCell {
    
    static let identifier = "NotificationLikeEventTableViewCell"
    
    public weak var delegate: NotificationLikeEventTableViewCellDelegate?
    
    private var model: UserNotification?
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .label
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 0
        label.text = "Hello world"
        return label
    }()
    
    private let postButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "gradient"), for: .normal)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(profileImageView)
        contentView.addSubview(label)
        contentView.addSubview(postButton)
        postButton.addTarget(self,
                             action: #selector(didTapPostButton),
                             for: .touchUpInside)
        selectionStyle = .none  
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        postButton.setTitle(nil, for: .normal)
        postButton.backgroundColor = .none
        postButton.layer.borderWidth = 0
        label.text = nil
        profileImageView.image = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // photo\text\post button
        profileImageView.frame = CGRect(x: 3, y: 3, width: contentView.height - 6, height: contentView.height - 6)
        profileImageView.layer.cornerRadius = profileImageView.height / 2
        let size = contentView.height - 4
        postButton.frame = CGRect(x: contentView.width - 5 - size, y: 2, width: size, height: size)
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
            postButton.sd_setBackgroundImage(with: thumbnail,
                                             for: .normal,
                                             completed: nil)
            break
        case .follow:
            break
        }
        label.text = model.text
        profileImageView.sd_setImage(with: model.user.profilePhoto, completed: nil)
    }
    
    @objc func didTapPostButton() {
        guard let model = model else {
            return
        }
        self.delegate?.didTapRelatedPostButton(model: model)
    }
}
