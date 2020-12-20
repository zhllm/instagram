//
//  ZLFeedPostGenaeralTableViewCell.swift
//  instagram
//
//  Created by 张杰 on 2020/12/17.
//

import UIKit

class ZLFeedPostGenaeralTableViewCell: UITableViewCell {
    static public let identifier = "ZLFeedPostGenaeralTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemOrange
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
