//
//  WXHomeContactTableViewCell.swift
//  instagram
//
//  Created by 张杰 on 2020/12/21.
//

import SDWebImage
import UIKit

public let WXHomeContactTableViewCellHeight: CGFloat = 80;

/// 用户聊天记录项
struct UserRecord {
    let username: String
    let time: Date
    let lastChatMessage: String
    let userIcon: String
}

class WXHomeContactTableViewCell: UITableViewCell {

    public static let identifier = "WXHomeContactTableViewCell"
    
    private var model: UserRecord?
    
    private var separatorLine: UIView = {
        let view = UIView()
        view.backgroundColor = .secondarySystemBackground
        return view
    }()
    
    private var userPhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = CGFloat(4)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private var usernameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.textColor = .label
        return label
    }()
    
    private var contentLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .secondaryLabel
        label.numberOfLines = 1
        return label
    }()
    
    private var timerLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .secondaryLabel
        label.numberOfLines = 1
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(contentLabel)
        contentView.addSubview(usernameLabel)
        contentView.addSubview(userPhotoImageView)
        contentView.addSubview(timerLabel)
        contentView.addSubview(separatorLine)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let padding: CGFloat = 16
        let size = contentView.height - padding * 2
        
        userPhotoImageView.frame = CGRect(
            x: 4,
            y: padding,
            width: size,
            height: size
        )
        
        // usernameLabel
        
        timerLabel.frame = CGRect(
            x: contentView.width - 64,
            y: padding,
            width: 40,
            height: 20
        )
        let usernameWidth = contentView.width - userPhotoImageView.width - 12 - timerLabel.width
        usernameLabel.frame = CGRect(
            x: userPhotoImageView.right + 4,
            y: padding,
            width: usernameWidth,
            height: 20
        )
        contentLabel.frame = CGRect(
            x: userPhotoImageView.right + 4,
            y: usernameLabel.bottom + 8,
            width: usernameWidth + timerLabel.width,
            height: 20
        )
        
        separatorLine.frame = CGRect(
            x: userPhotoImageView.right + 4,
            y: contentView.height - 1, width: contentView.width - userPhotoImageView.width - 4,
            height: CGFloat(1)
        )
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        usernameLabel.text = nil
        userPhotoImageView.image = nil
        contentLabel.text = nil
        timerLabel.text = nil
    }
    
    func configUserRecordCell(with model: UserRecord) {
        self.model = model
        usernameLabel.text = model.username
        userPhotoImageView.sd_setImage(with: URL(string: model.userIcon)!, completed: nil)
        timerLabel.text = model.time.zl_dateDescription
        contentLabel.text = model.lastChatMessage
    }
}
