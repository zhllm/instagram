//
//  WXHomeSearchTableViewCell.swift
//  instagram
//
//  Created by 张杰 on 2020/12/21.
//

import UIKit

protocol WXHomeSearchTableViewCellDelegate: AnyObject {
    func didTapSearchBar()
}

class WXHomeSearchTableViewCell: UITableViewCell {
    
    public static let identifier = "WXHomeSearchTableViewCell"

    private var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        return searchBar
    }()
    
    public weak var delegate: WXHomeSearchTableViewCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(searchBar)
        // searchBar.
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureSearchBar()
    }
    
    func configureSearchBar() {
        searchBar.frame = CGRect(
            x: 4,
            y: 8,
            width: contentView.width - 8,
            height: contentView.height - 16
        )
        contentView.backgroundColor = .secondarySystemBackground
        let textField = searchBar.subviews[0].subviews.last?.subviews.first
        let textFieldContainer = searchBar.subviews[0].subviews.last
        textFieldContainer?.backgroundColor = .secondarySystemBackground
        textField?.backgroundColor = .white
        let gesture =  UITapGestureRecognizer(target: self, action: #selector(didTapSearchBar))
        self.contentView.addGestureRecognizer(gesture)
    }
    
    @objc func didTapSearchBar() {
        print("tap cell ")
        self.delegate?.didTapSearchBar()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
