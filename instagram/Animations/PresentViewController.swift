//
//  PresentViewController.swift
//  instagram
//
//  Created by 张杰 on 2020/12/27.
//

import UIKit
import SnapKit

class PresentViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .orange
        self.title = "搜索页"
        let button = UIButton()
        button.setTitle("返回微信首页", for: .normal)
        button.setTitleColor(.label, for: .normal)
        self.view.addSubview(button)
        button.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(60)
        }
        button.addTarget(self, action: #selector(didTapReturnWXpageButton), for: .touchUpInside)
    }
    
    @objc func didTapReturnWXpageButton() {
        dismiss(animated: true, completion: nil)
    }

}
