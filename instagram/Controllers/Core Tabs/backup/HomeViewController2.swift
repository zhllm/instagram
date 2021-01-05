//
//  ViewController.swift
//  instagram
//
//  Created by 张杰 on 2020/12/16.
//

import UIKit
import FirebaseAuth
import SnapKit

let categories = ["cat", "dog", "tree", "house"]
let messages = [
    "今夕何夕兮，搴舟中流。今日何日兮，得与王子同舟。蒙羞被好兮，不訾诟耻。心几烦而不绝兮，得知王子。山有木兮木有枝，心悦君兮君不知。",
    "今晚是怎样的晚上啊我驾着小舟在河上漫游。今天是什么日子啊能够与王子同船泛舟。",
    "译文",
    "拔。搴舟，犹言荡舟。洲：当从《北堂书钞》"
]

let baseImageUrl = "https://cdn.pixabay.com/photo/2017/02/20/18/03/cat-2083492_150.jpg"

class HomeViewController2: UIViewController {
    
    private var models = [UserRecord]()
    
    private var currentPresentType = PresentType.prsent
    
    private var headerView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        return view
    }()
    
    
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(WXHomeContactTableViewCell.self,
                           forCellReuseIdentifier: WXHomeContactTableViewCell.identifier)
        tableView.register(
            WXHomeSearchTableViewCell.self,
            forCellReuseIdentifier: WXHomeSearchTableViewCell.identifier
        )
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureModels()
        configureTable()
        configNavigationItem()
        self.edgesForExtendedLayout = .top
        self.title = "首页"
    }
    
    func configureTable() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.layoutMargins = .zero
        tableView.preservesSuperviewLayoutMargins = false
        tableView.separatorStyle = .none
        tableView.tableHeaderView = headerView
        headerView.frame = CGRect(x: 0,
                                  y: 0,
                                  width: view.width,
                                  height: 88)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = CGRect(x: 0,
                                 y: 0,
                                 width: view.width,
                                 height: view.height)
    }
    
    private func configNavigationItem() {
        
        navigationController?.navigationBar.setBackgroundImage(
            UIImage(named: "whitebg"),
            for: .default
        )
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationItem.titleView?.backgroundColor = .secondarySystemBackground
    }
    
    private func configureModels() {
        for x in 0..<100 {
            let category = categories[x % 4]
            let userRecord = UserRecord(
                username: "\(category) - \(x)",
                time: Date(),
                lastChatMessage: messages[x % 4],
                userIcon: baseImageUrl
            )
            models.append(userRecord)
        }
    }
}


// MARK: - UITableViewDelegate
extension HomeViewController2: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 60
        }
        return WXHomeContactTableViewCellHeight
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: WXHomeSearchTableViewCell.identifier,
                for: indexPath) as! WXHomeSearchTableViewCell
            cell.delegate = self
            return cell
        }
        let cell = tableView.dequeueReusableCell(
            withIdentifier: WXHomeContactTableViewCell.identifier,
            for: indexPath
        ) as! WXHomeContactTableViewCell
        cell.configUserRecordCell(with: models[indexPath.row])
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.navigationController?.navigationBar.isHidden = true
        self.tableView.setContentOffset(CGPoint(x: 0, y: 188), animated: true)
        self.navigationController?.automaticallyAdjustsScrollViewInsets = false
        print("12312312312321")
        return
        let vc = PresentViewController()
        vc.transitioningDelegate = self
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
}


extension HomeViewController2: WXHomeSearchTableViewCellDelegate {
    func didTapSearchBar() {
        let vc = UIViewController()
        vc.view.frame = self.view.bounds
        vc.view.backgroundColor = .orange
        vc.title = "new Page "
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomeViewController2: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return HalfWaySpringAnimator(type: .prsent) { [weak self] in
            guard self != nil else {
                return
            }
            self!.presentAnimations()
        }
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return HalfWaySpringAnimator(type: .dismis) { [weak self] in
            guard self != nil else {
                return
            }
            // self!.presentAnimations()
        }
    }
    
    private func presentAnimations() {
        self.navigationController?.hidesBarsOnSwipe = true
        self.tableView.setContentOffset(CGPoint(x: 0, y: 88), animated: true)
    }

}
