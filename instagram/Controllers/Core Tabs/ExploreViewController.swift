//
//  ExploreViewController.swift
//  instagram
//
//  Created by 张杰 on 2020/12/16.
//

import UIKit

class ExploreViewController: UIViewController {

    private let searchBar: UISearchBar = {
        let bar = UISearchBar()
        bar.backgroundColor = .secondarySystemBackground
        return bar
    }()
    
    private let dimendView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0
        view.isHidden = true
        return view
    }()

    
    private var models = [UserPost]()
    
    private var collectionView: UICollectionView!
    
    private var tabbedSearchCollectionView: UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureExploreCollection()
        configureSearchBar()
        configureDimendView()
        UIView.animate(withDuration: 1) { [weak self] in
            guard let weakSelf = self else {
                return
            }
            weakSelf.navigationController?.view.frame = CGRect(
                x: 0,
                y: CGFloat(-20), // weakSelf.navigationController!.view.height
                width: weakSelf.navigationController!.view.width,
                height: weakSelf.navigationController!.view.height
            )
        }
    }
    
    private func configureTabbedSearch() {
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.width / 3, height: 52)
        layout.scrollDirection = .horizontal
        tabbedSearchCollectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        tabbedSearchCollectionView?.backgroundColor = .yellow
        tabbedSearchCollectionView?.isHidden = false
        guard let tabbedSearchCollectionView = tabbedSearchCollectionView else {
            return
        }
        tabbedSearchCollectionView.dataSource = self
        tabbedSearchCollectionView.delegate = self
        view.addSubview(tabbedSearchCollectionView)
    }
    
    private func configureDimendView() {
        view.addSubview(dimendView)
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapCancel))
        gesture.numberOfTapsRequired = 1
        gesture.numberOfTapsRequired = 1
        dimendView.addGestureRecognizer(gesture)
    }
    
    private func configureSearchBar() {
        // 着重要去了解下navigationBar的结构
        navigationController?.navigationBar.topItem?.titleView = searchBar
        searchBar.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
        dimendView.frame = view.bounds
        tabbedSearchCollectionView?.frame = CGRect(
            x: 0,
            y: view.safeAreaInsets.top,
            width: view.width,
            height: 75
        )
    }
}

// MARK: - UICollectionViewDelegate
extension ExploreViewController: UICollectionViewDelegate,
                                 UICollectionViewDelegateFlowLayout,
                                 UICollectionViewDataSource {
    
    
    private func configureExploreCollection() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: (view.width - 4) / 3, height: (view.width - 4) / 3)
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.addSubview(collectionView)
        collectionView.register(
            PhotoCollectionViewCell.self,
            forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier
        )
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == tabbedSearchCollectionView {
            return 0
        }
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == tabbedSearchCollectionView {
            return UICollectionViewCell()
        }
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: PhotoCollectionViewCell.identifier,
            for: indexPath
        ) as? PhotoCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: "gradient")
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        if collectionView == tabbedSearchCollectionView {
            return
        }
        // let model = models[indexPath.item]
        let user = User(
            username: "",
            bio: "",
            name: (first: "String", last: "String"),
            birthDate: Date(),
            gender: .female,
            counts: UserCount(followers: 0, following: 0, posts: 0), profilePhoto: URL(string: "https://www.google.com")!,
            joinDate: Date()
        )
        let post = UserPost(
            identifier: "",
            postType: .photo,
            thumbnailImage: URL(string:"https://www.google.com")!,
            postURL: URL(string: "https://www.google.com")!,
            caption: nil,
            likeCount: [],
            comments: [],
            createDate: Date(),
            taggeUsers: [],
            owner: user
        )
        let vc = PostViewController(model: post)
        vc.title = post.postType.rawValue
        navigationController?.pushViewController(vc, animated: true)
    }

    
}

// MARK: - UISearchBarDelegate
extension ExploreViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        didTapCancel()
        guard let text = searchBar.text, !text.isEmpty else {
            return
        }
        query(text)
    }
    
    func query(_ text: String) {
         
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Cancel",
            style: .plain,
            target: self,
            action: #selector(didTapCancel)
        )
        dimendView.isHidden = false
        UIView.animate(withDuration: 0.2) {
            self.dimendView.alpha = 0.4
        } completion: { (done) in
            if (done) {
                self.tabbedSearchCollectionView?.isHidden = false
            }
        }


    }
    
    @objc private func didTapCancel() {
        searchBar.resignFirstResponder()
        navigationItem.rightBarButtonItem = nil
        self.tabbedSearchCollectionView?.isHidden = true
        UIView.animate(withDuration: 0.2) {
            self.dimendView.alpha = 0
        } completion: { (done) in
            if (done) {
                self.dimendView.isHidden = true
            }
        }

    }
    
}

