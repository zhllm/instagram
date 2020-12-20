//
//  ProfileTabsCollectionReusableView.swift
//  instagram
//
//  Created by 张杰 on 2020/12/18.
//

import UIKit

protocol ProfileTabsCollectionReusableViewDelegate: AnyObject {
    func didTapGridButton()
    func didTapTaggButton()
}

class ProfileTabsCollectionReusableView: UICollectionReusableView {
    static let identifier = "ProfileTabsCollectionReusableView"
    
    public weak var delegate: ProfileTabsCollectionReusableViewDelegate?
    
    struct Constant {
        static let padding: CGFloat = 8
    }
    
    private let gridButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.tintColor = .systemBlue
        button.setBackgroundImage(UIImage(systemName: "square.grid.2x2"), for: .normal)
        return button
    }()
    
    private let taggButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.tintColor = .lightGray
        button.setBackgroundImage(UIImage(systemName: "tag"), for: .normal)
        return button
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        addSubview(taggButton)
        addSubview(gridButton)
        gridButton.addTarget(self, action: #selector(didTapGridButton), for: .touchUpInside)
        taggButton.addTarget(self, action: #selector(didTapTaggButton), for: .touchUpInside)
    }
    
    @objc private func didTapGridButton() {
        gridButton.tintColor = .systemBlue
        taggButton.tintColor = .lightGray
        self.delegate?.didTapGridButton()
    }
    
    @objc private func didTapTaggButton() {
        gridButton.tintColor = .lightGray
        taggButton.tintColor = .systemBlue
        self.delegate?.didTapTaggButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let size = height - (Constant.padding * 2)
        let gridButtonX = (width / 2 - size) / 2
        taggButton.frame = CGRect(x: gridButtonX,
                                  y: Constant.padding,
                                  width: size,
                                  height: size)
        
        gridButton.frame = CGRect(x: gridButtonX + width / 2,
                                  y: Constant.padding,
                                  width: size,
                                  height: size)
    }

    
}
