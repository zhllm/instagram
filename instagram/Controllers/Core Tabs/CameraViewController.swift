//
//  CameraViewController.swift
//  instagram
//
//  Created by 张杰 on 2020/12/16.
//
import AVFoundation
import UIKit
import Foundation
import MJRefresh

public struct CategoryLevel1 {
    var label: String
    var id: Int
    var level: Int
    var children: [CategoryLevel1]
}

class CategoryLevel {
    var label: String
    var id: Int
    var level: Int
    var children: [CategoryLevel]
    init(index: Int, level: Int) {
        label = "self \(index))"
        id = Int(arc4random())
        self.level = level
        children = [CategoryLevel]()
    }
}

class CameraViewController: UIViewController {
    private var collectionCanScroll = false
    private var scrollViewCanScroll = true
    public var collectionView: UICollectionView!
    private var scrollView: CustomUIScrollView!
    private weak var layout: UICollectionViewFlowLayout?
    private var leftTableView: UITableView = {
        let table = UITableView()
        return table
    }()
    
    private var segmentTableView: UICollectionView!
    
    // 顶部刷新
    private let header = MJRefreshNormalHeader()
    // 底部刷新
    private let footer = MJRefreshAutoNormalFooter()
    
    private var currentIndex: Int?
    
    private var categories = [CategoryLevel]()
    
    private var maxLevel = 1
    
    @objc func generateModel() {
        repeats(collection: &categories, level: 1)
        currentIndex = 0
        leftTableView.reloadData()
        segmentTableView.reloadData()
        collectionView.reloadData()
    }
    
    private func repeats(collection: inout [CategoryLevel], level: Int) {
        if level > 3 { return }
        let total = level > 1 ? 20 : 10
        for _ in 0..<total {
            let model = CategoryLevel(index: Int(arc4random()), level: level)
            collection.append(model)
            repeats(collection: &model.children, level: level + 1)
        }
    }
    
    func startTimer() {
       Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(generateModel), userInfo: nil, repeats: false)
    }
    
    
    private var headerView: UIView = {
        let view = UIView()
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemBackground
        configureScrollView()
        configureCollectionView()
        configureTableView()
        configureSegmentTableView()
        // generateModel
        startTimer()
        NotificationCenter.default.addObserver(self, selector: #selector(configContentSize), name: NSNotification.Name(rawValue: CustomLayout.notifyKey), object: nil)
    }
    
    func configureSegmentTableView() {
        let bounds = CGRect(
            x: headerView.left,
            y: headerView.top + headerView.height - 28,
            width: headerView.width,
            height: 28)
        // segmentTableView =
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 2
        layout.scrollDirection = .horizontal
        segmentTableView = UICollectionView(frame: bounds, collectionViewLayout: layout)
        segmentTableView.dataSource = self
        segmentTableView.delegate = self
        segmentTableView.register(SegementViewCell.self, forCellWithReuseIdentifier: SegementViewCell.identifier)
        segmentTableView.backgroundColor = .white
        segmentTableView.showsHorizontalScrollIndicator = false
        headerView.addSubview(segmentTableView)
    }
    
    /// configureTableView
    private func configureTableView() {
        let views = UIView()
        view.addSubview(views)
        views.frame = CGRect(
            x: 0,
            y: view.top + 4,
            width: view.width / 4,
            height: view.height
        )
        views.addSubview(leftTableView)
        leftTableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        leftTableView.delegate = self
        leftTableView.dataSource = self
        leftTableView.separatorStyle = .none
        leftTableView.backgroundColor = .secondarySystemBackground
        leftTableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
    }
    
    /// configureScrollView
    private func configureScrollView() {
        let views = UIView()
        view.addSubview(views)
        views.frame = CGRect(
            x: view.width / 4,
            y: ZL_naviBarHeight + 16,
            width: view.width / 4 * 3,
            height: view.height - ZL_bottomTabBarHeight - headerView.height
        )
        views.backgroundColor = .secondarySystemBackground
        scrollView = CustomUIScrollView(
            frame: CGRect(
                x: view.width / 4,
                y: views.top,
                width: view.width / 4 * 3,
                height: views.height
            ))
        views.addSubview(scrollView)
        scrollView.backgroundColor = .white
        scrollView.layer.cornerRadius = 4
        //scrollView.layer.masksToBounds = true
        
        scrollView.addSubview(headerView)
        headerView.frame = CGRect(x: 0,
                                  y: 0,
                                  width: scrollView.width,
                                  height: 160)
        headerView.backgroundColor = .green
        view.addSubview(scrollView)
        scrollView.isScrollEnabled = true
        scrollView.delegate = self
    }
    
    /// configureCollectionView
    private func configureCollectionView() {
        let layout = CustomLayout()
        self.layout = layout
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        let size = (view.width - 24) / 3
        layout.itemSize = CGSize(width: size, height: size)
        layout.scrollDirection = .vertical
        
        self.collectionView = UICollectionView(
            frame: CGRect(
                x: 0,
                y: headerView.bottom,
                width: scrollView.width,
                height: scrollView.height - ZL_bottomTabBarHeight - 100
            ),
            collectionViewLayout: layout
        )
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self,
                                forCellWithReuseIdentifier: "UICollectionViewCell")
        collectionView.backgroundColor = .white
        
        collectionView.bounces = true
        collectionView.alwaysBounceVertical = true
        // 下拉刷新
        header.setRefreshingTarget(self, refreshingAction: #selector(getNext))
        // 现在的版本要用mj_header
        self.scrollView.mj_header = header

        // 上拉刷新
        footer.setRefreshingTarget(self, refreshingAction: #selector(getNext))
        self.collectionView.mj_footer = footer
        
        
        // https://pixabay.com/photos/stained-glass-spiral-circle-pattern-1181864/
        scrollView.addSubview(collectionView)
    }
    
    @objc func getNext() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            self.scrollView.mj_header?.endRefreshing()
            self.collectionView.mj_footer?.endRefreshing()
        }
    }
    
    @objc func configContentSize() {
        guard layout != nil else {
            return
        }
        self.scrollView.contentSize = CGSize(
            width: scrollView.width,
            height: self.layout!.collectionViewContentSize.height + headerView.height//  + headerView.height + 60
        )
    }

}
 
// MARK: - UITableViewDelegate,UITableViewDataSource
extension CameraViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        let label = UILabel(frame: cell.bounds)
        label.text = categories[indexPath.row].label
        label.textAlignment = .center
        label.textColor = .secondaryLabel
        cell.contentView.addSubview(label)
        cell.backgroundColor = .secondarySystemBackground
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.selectedBackgroundView = UIView(frame: cell?.bounds ?? .zero)
        cell?.selectedBackgroundView?.backgroundColor = .white
        currentIndex = indexPath.row
        collectionView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}


// MARK: - UICollectionViewDelegateFlowLayout, UICollectionViewDataSource
extension CameraViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
   
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionView == self.collectionView {
            return categories.count
        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.segmentTableView {
            return categories.count
        }
        if currentIndex == nil { return 0 }
        let sec = categories[section]
        return sec.children.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == segmentTableView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SegementViewCell.identifier, for: indexPath) as! SegementViewCell
            cell.setNormalContent(text: categories[indexPath.item].label)
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UICollectionViewCell", for: indexPath)
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        let imageView = UIImageView()
        cell.contentView.addSubview(imageView)
        cell.contentView.backgroundColor = .secondarySystemBackground
        let padding: CGFloat = 10
        let size = cell.width - 2 * padding
        imageView.frame = CGRect(
            x: padding, y: padding, width: size, height: size
        )
        imageView.backgroundColor = .lightGray
        imageView.layer.cornerRadius = imageView.width / 2
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.sd_setImage(with: URL(string: "https://cdn.pixabay.com/photo/2018/02/21/08/40/woman-3169726_1280.jpg"), completed: nil)
        let label = UILabel(frame: CGRect(
                                x: padding,
                                y: imageView.bottom,
                                width: size,
                                height: 30))
        label.text = "\(categories[currentIndex!].children[indexPath.item].level)\(categories[currentIndex!].children[indexPath.item].label)"
        cell.contentView.addSubview(label)
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == segmentTableView {
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            guard let cell = collectionView.cellForItem(at: indexPath) as? SegementViewCell else {
                return
            }
            cell.selectedCell()
            UIView.animate(withDuration: 0.2) {
                self.scrollView.contentOffset = CGPoint(x: 0, y: 100)
            } completion: { (complete) in
                if complete {
                    self.collectionView.scrollToItem(
                        at: IndexPath(item: 0, section: indexPath.item),
                        at: .top,
                        animated: true
                    )
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if collectionView == segmentTableView {
            guard let cell = collectionView.cellForItem(at: indexPath) as? SegementViewCell else {
                return
            }
            cell.deselectedCell()
//            currentIndex = indexPath.item
//            self.collectionView.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == segmentTableView {
            return CGSize(width: 100, height: self.segmentTableView.height )
        }
        let size = (self.collectionView.width - 40) / 3
        return CGSize(width: size, height: size + 30)
    }
}

// MARK: - UIScrollViewDelegate
extension CameraViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == leftTableView {
            return
        }
        
        if scrollView == segmentTableView  {
            return
        }
        
        if scrollView == self.scrollView {
            if !scrollViewCanScroll {
                if self.collectionView.contentSize.height - self.collectionView.contentOffset.y <= self.view.height {
                    // 当collectionView滑动到底部的时候，这时collectionView就不再滚动，滚动的就是scrollView
                    // 但是scrollView 的offset是被锁定到 y = 100 处，所以导致collectionView滑动到底部失去了回弹效果
                    self.scrollView.isScrollEnabled = false
                }
                scrollView.contentOffset.y = 100
                collectionCanScroll = true
            } else if scrollView.contentOffset.y >= 100 {
                scrollView.contentOffset.y = 100
                scrollViewCanScroll = false
                collectionCanScroll = true
            }
        } else  {
            let firstCell = collectionView.visibleCells.last
            if collectionView.contentOffset.y < self.view.height {
                self.scrollView.isScrollEnabled = true
            }
            if !collectionCanScroll {
                scrollView.contentOffset.y = 0
            } else if collectionView.contentOffset.y <= 0 {
                collectionCanScroll = false
                scrollViewCanScroll = true
            }
        }
        print("scrollView cell y", self.scrollView.contentSize.height)
        print("collectionView cell y",  self.collectionView.contentSize.height)
        print("scrollView cell y", self.scrollView.contentOffset.y)
        print("collectionView cell y \n \n \n \n \n ",  self.collectionView.contentOffset.y)
        
        if scrollViewCanScroll {
            self.scrollView.showsVerticalScrollIndicator = true
            collectionView.showsVerticalScrollIndicator = false
        } else {
            self.scrollView.showsVerticalScrollIndicator = false
            collectionView.showsVerticalScrollIndicator = true
        }
    }
}
