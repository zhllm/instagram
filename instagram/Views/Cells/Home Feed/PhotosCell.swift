//
//  PhotosCell.swift
//  instagram
//
//  Created by 张杰 on 2021/1/3.
//

import UIKit
import SDWebImage
import SnapKit

class PhotosCell: UICollectionViewCell {
    
    static public let identifier = "PhotosCell"
    
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(imageView)
        imageView.frame = self.contentView.bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setContent(model: Post) {
        
        imageView.sd_setImage(with: URL(string: model.previewURL!), completed: nil)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    override func layoutSubviews() {
        self.imageView.frame = self.bounds
        
    }
    
    
}
