//
//  ZLPostTableViewCell.swift
//  instagram
//
//  Created by 张杰 on 2020/12/17.
//

import UIKit

class ZLFeedPostTableViewCell: UITableViewCell {
    
    static public let identifier = "ZLPostTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .secondarySystemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure() {
        // configure the cell
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
}
