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
    var checked: Bool = false
    
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
        self.backgroundColor = .secondarySystemBackground
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 12
        self.layer.borderColor = UIColor.clear.cgColor
        let backView = UIView(frame: self.bounds)
        backView.backgroundColor = UIColor(red: 220 / 255, green: 20 / 255, blue: 60 / 255, alpha: 0.1)
        backView.layer.borderWidth = 1
        backView.layer.cornerRadius = 12
        backView.layer.borderColor = UIColor(red: 220 / 255, green: 20 / 255, blue: 60 / 255, alpha: 1).cgColor
        selectedBackgroundView = backView
    }
    
    public func setNormalContent(text: String) {
        label.text = text
    }
    
    public func selectedCell() {
        label.textColor = UIColor(red: 220 / 255, green: 20 / 255, blue: 60 / 255, alpha: 1)
        self.backgroundColor = .white
        checked = true
    }
    
    public func deselectedCell() {
        label.textColor = .secondaryLabel
        self.backgroundColor = .secondarySystemBackground
        checked = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        label.text = ""
    }
    
}
