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
import ObjectMapper
import SnapKit

public struct CategoryLevel1: Mappable {
    public init?(map: Map) {
        label = ""
        id = 0
        level = 1
    }
    
    public mutating func mapping(map: Map) {
        self.label <- map["label"]
        self.id <- map["id"]
        self.level <- map["level"]
    }
    
    var label: String
    var id: Int
    var level: Int
}

public struct MainCategories: Mappable {
    public init?(map: Map) {
        categories = [CategoryLevel1]()
    }
    
    public mutating func mapping(map: Map) {
        categories <- map["categories"]
    }
    
    var categories: [CategoryLevel1]
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
    
    private var models: [Post] = []
    
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
    
    private var mainCategory: MainCategories?
    
    private lazy var searchController: UISearchController = {
        let searchVc = UISearchController(searchResultsController: nil)
        return searchVc
    }()
    
    private var maxLevel = 1
    
    private var currentFirstSection = 0
    
    @objc func getModels() {
        NetworkAPI.imagePostList(params: ["page":1, "per_page": 200]) { (response) in
            switch response{
            case let .success(data):
                self.models = self.models + data.hits!
                self.generateModel()
            case let .failure(error):
                debugPrint("NetworkAPI.imagePostList" + error.localizedDescription)
            }
        }
    }
    
    @objc func generateModel() {
        let path = Bundle.main.path(forResource: "main_categories", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        do {
            let jsonString = try String(contentsOf: url, encoding: .utf8)
            self.mainCategory = MainCategories(JSONString: String(jsonString))
        } catch let error {
            print(error)
        }
        repeats(collection: &categories, level: 1)
        currentIndex = 0
        leftTableView.reloadData()
        collectionView.reloadData()
        segmentTableView.reloadData()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) { [weak self] in
            guard self != nil else { return }
            let indexPath = IndexPath(item: 0, section: 0)
            self!.segmentTableView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
            self?.leftTableView.selectRow(at: indexPath, animated: true, scrollPosition: .top)
            guard let cell = self!.segmentTableView.cellForItem(at: indexPath) as? SegementViewCell else {
                print("cell is nil")
                return
            }
            cell.selectedCell()
        }
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
       Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(getModels), userInfo: nil, repeats: false)
    }
    
    
    private var headerView: UIView = {
        let view = UIView()
        return view
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // extendedLayoutIncludesOpaqueBars = true
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Candies21212"
        // self.navigationController?.navigationBar.isTranslucent = true
        definesPresentationContext = true
        navigationItem.searchController = searchController
        // searchController.definesPresentationContext = false
        //searchController.hidesNavigationBarDuringPresentation = false
        // searchController.searchBar.frame = CGRect(x: 0, y: 0, width: view.width, height: 44)
//        let titleView = UIView(frame: CGRect(x: 70, y: 0, width: 300, height: 32))
//        navigationItem.titleView = titleView
//        titleView.addSubview(searchController.searchBar)
//        searchController.searchBar.snp.makeConstraints { (make) in
//            make.edges.equalToSuperview()
//        }
        
        
        view.backgroundColor = .secondarySystemBackground
        configureScrollView()
        configureCollectionView()
        configureTableView()
        configureSegmentTableView()
        startTimer()
        NotificationCenter.default.addObserver(self, selector: #selector(configContentSize), name: NSNotification.Name(rawValue: CustomLayout.notifyKey), object: nil)
        
        guard let bar = self.navigationController?.navigationBar as? CustomNavBar else {
            return
        }
    }
    
    func configureSegmentTableView() {
        let backView = UIView(frame: CGRect(
                                x: headerView.left,
                                y: headerView.top + headerView.height - 40,
                                width: headerView.width,
                                height: 40))
        backView.backgroundColor = .white
        // segmentTableView =
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 8
        layout.scrollDirection = .horizontal
        headerView.addSubview(backView)
        let imageHeader = UIImageView()
        imageHeader.sd_setImage(with: URL(string: "https://cdn.pixabay.com/photo/2015/12/22/14/37/sandwiches-1104188_1280.jpg"), completed: nil)
        headerView.addSubview(imageHeader)
        imageHeader.frame = CGRect(x: 10, y: 10, width: headerView.width - 20, height: 100)
        imageHeader.contentMode = .scaleAspectFill
        imageHeader.layer.cornerRadius = 4
        imageHeader.layer.masksToBounds = true
        segmentTableView = UICollectionView(frame: CGRect(
                                                x: 0,
                                                y: 8,
                                                width: backView.width,
                                                height: 24), collectionViewLayout: layout)
        segmentTableView.dataSource = self
        segmentTableView.delegate = self
        segmentTableView.register(SegementViewCell.self, forCellWithReuseIdentifier: SegementViewCell.identifier)
        segmentTableView.backgroundColor = .white
        segmentTableView.showsHorizontalScrollIndicator = false
        backView.addSubview(segmentTableView)
    }
    
    /// configureTableView
    private func configureTableView() {
        let views = UIView()
        view.addSubview(views)
        views.frame = CGRect(
            x: 0,
            y: view.top + ZL_naviBarHeight + 6,
            width: view.width / 4,
            height: view.height
        )
        views.addSubview(leftTableView)
        leftTableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        leftTableView.separatorInset = .zero
        leftTableView.separatorColor = .clear
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
            y: ZL_naviBarHeight + 6,
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
        headerView.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.isScrollEnabled = true
        scrollView.delegate = self
    }
    
    /// configureCollectionView
    private func configureCollectionView() {
        let layout = CustomLayout()
        self.layout = layout
        layout.delegate = self
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
                height: scrollView.height - 100
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
    
    func headerCollectionViewScroll(to sectionIndex: Int)  {
        let indexPath = IndexPath(item: sectionIndex, section: 0)
        segmentTableView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        guard let cell = segmentTableView.cellForItem(at: indexPath) as? SegementViewCell else {
            return
        }
        cell.selectedCell()
    }

}
 
// MARK: - UITableViewDelegate,UITableViewDataSource
extension CameraViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.mainCategory?.categories.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        if self.mainCategory == nil { return cell }
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        let y = (cell.height - 22) / 2
        let label = UILabel(frame: CGRect(x: 0, y: y, width: cell.width, height: 22))
        
        label.text = self.mainCategory!.categories[indexPath.row].label
        label.textAlignment = .center
        label.textColor = .secondaryLabel
        cell.contentView.addSubview(label)
        cell.contentView.layer.borderWidth = 0
        cell.backgroundColor = .white
        cell.contentView.backgroundColor = .secondarySystemBackground
        cell.selectedBackgroundView = UIView(frame: cell.bounds)
        cell.selectedBackgroundView?.backgroundColor = .clear
        
        if currentIndex != nil && currentIndex == indexPath.row {
            cell.contentView.backgroundColor = .white
            
            if let cell = tableView.cellForRow(at: IndexPath(row: indexPath.row - 1, section: 0)) {
                setCellCorner(cell: cell, corners: [[.bottomRight]])
            }
            if let cell = tableView.cellForRow(at: IndexPath(row: indexPath.row + 1, section: 0)) {
                setCellCorner(cell: cell, corners: [[.topRight]])
            }
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.contentView.backgroundColor = .white
        }
        
        if let cell = tableView.cellForRow(at: IndexPath(row: indexPath.row - 1, section: 0)) {
            setCellCorner(cell: cell, corners: [[.bottomRight]])
        }
        if let cell = tableView.cellForRow(at: IndexPath(row: indexPath.row + 1, section: 0)) {
            setCellCorner(cell: cell, corners: [[.topRight]])
        }
        currentIndex = indexPath.row
        collectionView.reloadData()
    }
    
    func setCellCorner(cell: UITableViewCell, corners: UIRectCorner) {
        let maskPath = UIBezierPath(roundedRect: cell.contentView.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: 16, height: 16))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = view.bounds
        maskLayer.path = maskPath.cgPath
        maskLayer.shouldRasterize = true
        maskLayer.rasterizationScale = UIScreen.main.scale
        cell.contentView.layer.mask = maskLayer
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.contentView.backgroundColor = .secondarySystemBackground
        }
        if let cell = tableView.cellForRow(at: IndexPath(row: indexPath.row - 1, section: 0)) {
            setCellCorner(cell: cell, corners: [[]])
        }
        if let cell = tableView.cellForRow(at: IndexPath(row: indexPath.row + 1, section: 0)) {
            setCellCorner(cell: cell, corners: [[]])
        }
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
            
            cell.setNormalContent(text: self.mainCategory?.categories[indexPath.item].label ?? "")
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UICollectionViewCell", for: indexPath)
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        
        let padding: CGFloat = 10
        let size = cell.width - 2 * padding
        let backView = UIView(frame: CGRect(
            x: 0, y: 0, width: cell.width , height: cell.width
        ))
        
        let imageView = UIImageView()
        cell.contentView.addSubview(backView)
        // cell.contentView.backgroundColor = .secondarySystemBackground
        backView.addSubview(imageView)
        backView.backgroundColor = .secondarySystemBackground
        imageView.frame = CGRect(
            x: padding, y: padding, width: size, height: size
        )
        imageView.backgroundColor = .lightGray
        imageView.layer.cornerRadius = imageView.width / 2
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.sd_setImage(with: URL(string: self.models[indexPath.item].previewURL!), completed: nil)
        let label = UILabel(frame: CGRect(
                                x: padding,
                                y: imageView.bottom + 16,
                                width: size,
                                height: 30))
        if currentIndex! <= categories.count - 1 {
            label.text =
                "\(categories[currentIndex!].children[indexPath.item].level)\(categories[currentIndex!].children[indexPath.item].label)"
        } else {
            label.text = "nil"
        }
        
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
        if collectionView == self.segmentTableView {
            return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        }
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == segmentTableView {
            guard let labelCont = self.mainCategory?.categories[indexPath.item].label.count else {
                return CGSize(width: 100, height: self.segmentTableView.height)
            }
            return CGSize(width: CGFloat(labelCont * 16 + 14), height: self.segmentTableView.height)
        }
        let size = (self.collectionView.width - 40) / 3
        return CGSize(width: size, height: size + 30)
    }
    
    func findTopSecion(set: NSMutableIndexSet) -> Int? {
        var currentFirstSection = 100
        for index in set {
            currentFirstSection = min(currentFirstSection, index)
        }
        let maxCount = self.collectionView.numberOfSections
        
        if currentFirstSection > maxCount {
            return nil
        }
        let count = self.collectionView.numberOfItems(inSection: currentFirstSection)
        let index = IndexPath(item: count - 1, section: currentFirstSection)
        let attr = self.layout?.layoutAttributesForItem(at: index)
        guard attr != nil else {
            return nil
        }
        if attr!.frame.origin.y + attr!.frame.size.height < self.collectionView.contentOffset.y {
            set.remove(currentFirstSection)
            return findTopSecion(set: set)
        }
        return currentFirstSection
    }

}

// MARK: - UIScrollViewDelegate
extension CameraViewController: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == leftTableView {
            return
        }
        
        if scrollView == segmentTableView  {
            return
        }
        
        if scrollView == self.collectionView {
            let set = NSMutableIndexSet()
            for cell in collectionView.visibleCells {
                let indexPath = self.collectionView.indexPath(for: cell)
                if indexPath == nil {
                    continue
                }
                set.add(indexPath!.section)
            }
            guard let currentFirstSection = findTopSecion(set: set) else {
                return
            }
            
            print("currentFirstSection \(currentFirstSection)")
            if self.currentFirstSection != currentFirstSection {
                let index = IndexPath(item: currentFirstSection, section: 0)
                self.segmentTableView.selectItem(at: index, animated: true, scrollPosition: .centeredHorizontally)
                let preIndexPath = IndexPath(item: self.currentFirstSection, section: 0)
                let preCell = self.segmentTableView.cellForItem(at: preIndexPath) as? SegementViewCell
                self.segmentTableView.deselectItem(at: preIndexPath, animated: true)
                if preCell != nil {
                    preCell?.deselectedCell()
                }
                self.currentFirstSection = currentFirstSection
                guard let cell = self.segmentTableView.cellForItem(at: index) as? SegementViewCell else {
                    print("cell is nil")
                    return
                }
                cell.selectedCell()
            }
        }
        
        if scrollView == self.scrollView {
            if !scrollViewCanScroll {
                if self.collectionView.contentSize.height - self.collectionView.contentOffset.y <= self.view.height {
                    // 当collectionView滑动到底部的时候，这时collectionView就不再滚动，滚动的就是scrollView
                    // 但是scrollView 的offset是被锁定到 y = 100 处，所以导致collectionView滑动到底部失去了回弹效果
                    self.scrollView.isScrollEnabled = false
                }
                scrollView.contentOffset.y = 120
                collectionCanScroll = true
            } else if scrollView.contentOffset.y >= 120 {
                scrollView.contentOffset.y = 120
                scrollViewCanScroll = false
                collectionCanScroll = true
            }
        } else  {
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
        
        if scrollViewCanScroll {
            self.scrollView.showsVerticalScrollIndicator = true
            collectionView.showsVerticalScrollIndicator = false
        } else {
            self.scrollView.showsVerticalScrollIndicator = false
            collectionView.showsVerticalScrollIndicator = true
        }
    }
}


extension CameraViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}
