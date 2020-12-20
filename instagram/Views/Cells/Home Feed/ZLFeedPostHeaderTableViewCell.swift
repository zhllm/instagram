//
//  ZLFeedPostHeaderTableViewCell.swift
//  instagram
//
//  Created by 张杰 on 2020/12/17.
//

import UIKit

class ZLFeedPostHeaderTableViewCell: UITableViewCell {

    static public let identifier = "ZLFeedPostHeaderTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemBlue
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
