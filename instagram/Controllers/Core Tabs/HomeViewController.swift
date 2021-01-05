//
//  ViewController.swift
//  instagram
//
//  Created by 张杰 on 2020/12/16.
//

import UIKit
import SnapKit
import MBProgressHUD
import MJRefresh

class HomeViewController: UIViewController {
    
    private var collectionView: UICollectionView?
    private var models: [Post] = []
    private var page: Int = 1
    private var pageSize: Int = 20
    
    // 顶部刷新
    private let header = MJRefreshNormalHeader()
    // 底部刷新
    private let footer = MJRefreshAutoNormalFooter()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        // configureCollectionView()
        configureCollectionView()
        getModels()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func getModels(page: Int? = 1) {
        let hub = MBProgressHUD.showAdded(to: view, animated: true)
        NetworkAPI.imagePostList(params: ["page":page!, "per_page": pageSize]) { (response) in
            self.collectionView?.mj_header?.endRefreshing()
            self.collectionView?.mj_footer?.endRefreshing()
            switch response{
            case let .success(data):
                debugPrint(data.hits?.count ?? "0")
                self.models = self.models + data.hits!
                hub.hide(animated: true)
                self.collectionView?.reloadData()
            case let .failure(error):
                debugPrint("NetworkAPI.imagePostList" + error.localizedDescription)
            }
        }
    }
    
    func showLoginView() {
        let vc = ZLLoginViewController()
        let nvc = UINavigationController(rootViewController: vc)
        nvc.modalPresentationStyle = .fullScreen
        present(nvc, animated: true, completion: nil)
    }
    
    func configureCollectionView() {
        let layout = WaterFlowLayout()
        layout.minimumLineSpacing = 5.0
        layout.minimumInteritemSpacing = 5.0
        layout.delegate = self
        layout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView?.backgroundColor = .white
        collectionView?.register(PhotosCell.self, forCellWithReuseIdentifier: PhotosCell.identifier)
        collectionView?.delegate = self
        collectionView?.dataSource = self
        self.view.addSubview(collectionView!)
        
        // 下拉刷新
        header.setRefreshingTarget(self, refreshingAction: #selector(getNext))
        // 现在的版本要用mj_header
        self.collectionView!.mj_header = header
        
        // 上拉刷新
        footer.setRefreshingTarget(self, refreshingAction: #selector(getNext))
        self.collectionView!.mj_footer = footer
    }
    
    @objc func getNext() {
        self.page += 1
        getModels(page: self.page)
    }
}


extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCell.identifier, for: indexPath) as! PhotosCell
        let model = models[indexPath.item]
        cell.setContent(model: model)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard models.count != 0 else {
            return .zero
        }
        
        let model = models[indexPath.item]
        let width = CGFloat(model.previewWidth!)
        let height = CGFloat(model.previewHeight!)
        let itemWidth = (self.view.width - 20) / 3
        let widthRatio = width / itemWidth
        let scaleHeight = height * widthRatio
        return CGSize(width: itemWidth, height: scaleHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 4, left: 5, bottom: 4, right: 5)
    }
}
