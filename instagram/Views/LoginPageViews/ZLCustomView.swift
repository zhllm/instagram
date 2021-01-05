//
//  ZLCustomView.swift
//  instagram
//
//  Created by 张杰 on 2020/12/29.
//

import UIKit
import SnapKit

class ZLCustomView: UIView {
    
    private var content: NSMutableAttributedString?
    
    private var textView: UITextView = {
        let text = UITextView()
        return text
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setContent() {
        print(self.bounds)
        self.addSubview(textView)
        textView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        let str = "Terms and Conditions of Use";
        let attrStr = NSMutableAttributedString(string: str);
        attrStr.addAttributes([NSAttributedString.Key.link : "cilck://"], range: NSRange(location: 0, length: 5))
        attrStr.addAttributes([NSAttributedString.Key.link : "cilck://"], range: NSRange(location: 10, length: 17))
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        let attrs: [NSAttributedString.Key : Any] = [
            .font: UIFont.customFont(family: .AvenirBook, size: 16),
            .paragraphStyle: paragraphStyle,
            .backgroundColor: UIColor.white
        ]
        
        attrStr.addAttributes(attrs, range: NSRange(location: 0, length: str.count - 1))
        textView.textAlignment = .center
        textView.attributedText = attrStr;
        textView.delegate = self
        textView.isEditable = false
        textView.isScrollEnabled = false
    }
    
}

extension ZLCustomView: UITextViewDelegate{
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        if URL.scheme == "click" {
            print("click")
            return false
        }
        return true
    }
}
