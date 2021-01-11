//
//  SegementViewCell.swift
//  instagram
//
//  Created by 张杰 on 2021/1/10.
//

import UIKit
import SnapKit

class SegementViewCell: UICollectionViewCell {
    static let identifier = "SegementViewCell"
    
    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .secondaryLabel
        label.font = UIFont.customFont(family: .AvenirBook, size: 13)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        let backView = UIView(frame: self.bounds)
        backView.backgroundColor = .blue
        backView.layer.borderWidth = 1
        backView.layer.cornerRadius = 8
        backView.layer.borderColor = UIColor.systemPink.cgColor
        selectedBackgroundView = backView
    }
    
    public func setNormalContent(text: String) {
        label.text = text
    }
    
    public func selectedCell() {
        label.textColor = .white
    }
    
    public func deselectedCell() {
        label.textColor = .secondaryLabel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        label.text = ""
        // label.textColor = .secondaryLabel
    }
    
    
}
