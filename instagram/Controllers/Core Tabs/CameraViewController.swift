//
//  CameraViewController.swift
//  instagram
//
//  Created by 张杰 on 2020/12/16.
//
import AVFoundation
import UIKit

public struct CategoryLevel1 {
    var label: String
    var id: Float
    var level: Int
    var children: [CategoryLevel1]
}

class CameraViewController: UIViewController {
    private var collectionCanScroll = false
    private var scrollViewCanScroll = true
    private var collectionView: UICollectionView!
    private var scrollView: CustomUIScrollView!
    private weak var layout: UICollectionViewFlowLayout?
    private var leftTableView: UITableView = {
        let table = UITableView()
        return table
    }()
    
    private var categories = [CategoryLevel1]()
    
    
    private var headerView: UIView = {
        let view = UIView()
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        configureScrollView()
        configureCollectionView()
        configureTableView()
    }
    
    private func didTapPicture() {
        
    }
    
    /// configureTableView
    private func configureTableView() {
        view.addSubview(leftTableView)
        leftTableView.frame = CGRect(
            x: 0,
            y: view.top,
            width: view.width / 4,
            height: view.height)
        leftTableView.delegate = self
        leftTableView.dataSource = self
        leftTableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
    }
    
    /// configureScrollView
    private func configureScrollView() {
        scrollView = CustomUIScrollView(frame: CGRect(
                                            x: view.width / 4,
                                            y: view.top,
                                            width: view.width / 4 * 3,
                                            height: view.height - ZL_bottomTabBarHeight))
        scrollView.backgroundColor = .white
        scrollView.addSubview(headerView)
        headerView.frame = CGRect(x: 0,
                                  y: scrollView.top,
                                  width: scrollView.width,
                                  height: 160)
        headerView.backgroundColor = .green
        view.addSubview(scrollView)
        scrollView.isScrollEnabled = true
        scrollView.delegate = self
    }
    
    /// configureCollectionView
    private func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        self.layout = layout
        layout.minimumInteritemSpacing = 6
        layout.minimumLineSpacing = 6
        let size = (view.width - 24) / 3
        layout.itemSize = CGSize(width: size, height: size)
        layout.scrollDirection = .vertical
        
        self.collectionView = UICollectionView(
            frame: CGRect(x: 0,
                          y: headerView.bottom + 16,
                          width: scrollView.width,
                          height: view.height),
            collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self,
                                forCellWithReuseIdentifier: "UICollectionViewCell")
        collectionView.backgroundColor = .white
        // https://pixabay.com/photos/stained-glass-spiral-circle-pattern-1181864/
        scrollView.addSubview(collectionView)
        scrollView.contentSize = CGSize(width: scrollView.width, height: headerView.height + collectionView.height)
    }
    
    override func viewDidLayoutSubviews() {
        guard layout != nil else {
            return
        }
        self.scrollView.contentSize = CGSize(
            width: scrollView.width,
            height: self.layout!.collectionViewContentSize.height
        )
        
    }

}
 
// MARK: - UITableViewDelegate,UITableViewDataSource
extension CameraViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100 // categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        return cell
    }
    
    
}


// MARK: - UICollectionViewDelegateFlowLayout, UICollectionViewDataSource
extension CameraViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UICollectionViewCell", for: indexPath)
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        let imageView = UIImageView()
        cell.contentView.addSubview(imageView)
        imageView.frame = cell.contentView.bounds
        imageView.backgroundColor = .lightGray
        imageView.layer.cornerRadius = imageView.width / 2
        imageView.layer.masksToBounds = true
        return cell
    }
}

// MARK: - UIScrollViewDelegate
extension CameraViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == leftTableView {
            return
        }
        if scrollView == self.scrollView {
            if !scrollViewCanScroll {
                scrollView.contentOffset.y = 40
                collectionCanScroll = true
            } else if scrollView.contentOffset.y >= 40 {
                scrollView.contentOffset.y = 40
                scrollViewCanScroll = false
                collectionCanScroll = true
            }
        } else  {
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
