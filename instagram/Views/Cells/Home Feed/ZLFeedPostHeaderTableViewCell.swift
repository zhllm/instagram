//
//  ZLFeedPostHeaderTableViewCell.swift
//  instagram
//
//  Created by 张杰 on 2020/12/17.
//

import UIKit
import SDWebImage

protocol ZLFeedPostHeaderTableViewCellDelegate: AnyObject {
    func didTapMoreButton()
}

class ZLFeedPostHeaderTableViewCell: UITableViewCell {

    static public let identifier = "ZLFeedPostHeaderTableViewCell"
    
    public weak var delegate: ZLFeedPostHeaderTableViewCellDelegate?
    
    private let profilePhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let usernmaeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    
    private let moreButton: UIButton = {
        let button = UIButton()
        button.tintColor = .label
        button.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(profilePhotoImageView)
        contentView.addSubview(usernmaeLabel)
        contentView.addSubview(moreButton)
        moreButton.addTarget(self,
                             action: #selector(didTapMoreButton),
                             for: .touchUpInside)
    }
    
    @objc private func didTapMoreButton() {
        self.delegate?.didTapMoreButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with model: User) {
        // configure the cell
        usernmaeLabel.text = model.username
        profilePhotoImageView.image = UIImage(systemName: "person.circle")
        // profilePhotoImageView.sd_setImage(with: model.profilePhoto, completed: nil)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let size = contentView.height - 4
        profilePhotoImageView.frame = CGRect(x: 2, y: 2, width: size, height: size)
        profilePhotoImageView.layer.cornerRadius = size / 2
        moreButton.frame = CGRect(x: contentView.width - size,
                                  y: 2,
                                  width: size,
                                  height: size)
        usernmaeLabel.frame = CGRect(x: profilePhotoImageView.right + 10,
                                     y: 2,
                                     width: contentView.width - (size * 2) - 15,
                                     height: contentView.height - 4)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        profilePhotoImageView.image = nil
    }
    
}
