//
//  ViewController.swift
//  instagram
//
//  Created by 张杰 on 2020/12/16.
//

import UIKit
import FirebaseAuth

struct HomeFeedRenderViewType {
    let header: PostRenderViewModel
    let post: PostRenderViewModel
    let comments: PostRenderViewModel
    let actions: PostRenderViewModel
}

class HomeViewController: UIViewController {
    
    private var feedRenderModels = [HomeFeedRenderViewType]()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ZLFeedPostTableViewCell.self,
                           forCellReuseIdentifier: ZLFeedPostTableViewCell.identifier)
        tableView.register(ZLFeedPostHeaderTableViewCell.self,
                           forCellReuseIdentifier: ZLFeedPostHeaderTableViewCell.identifier)
        tableView.register(ZLFeedPostActionsTableViewCell.self,
                           forCellReuseIdentifier: ZLFeedPostActionsTableViewCell.identifier)
        tableView.register(ZLFeedPostGenaeralTableViewCell.self,
                           forCellReuseIdentifier: ZLFeedPostGenaeralTableViewCell.identifier)
        
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        handleNotAuthenticated()
        createMockModels()
    }
    
    private func createMockModels() {
        let user = User(username: "", bio: "", name: (first: "String", last: "String"), birthDate: Date(), gender: .female, counts: UserCount(followers: 0, following: 0, posts: 0), profilePhoto: URL(string: "https://www.google.com")!, joinDate: Date())
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
        var comments = [PostComment]()
        for x in 0..<2 {
            comments.append(PostComment(
                identifier: "\(x)",
                username: "Joe",
                text: "This is best beat",
                createDate: Date(),
                likes: []
            ))
        }
        for _ in 0..<5 {
            let viewModel = HomeFeedRenderViewType(
                header: PostRenderViewModel(renderType: .header(provider: user)),
                post: PostRenderViewModel(renderType: .primaryCount(provide: post)),
                comments: PostRenderViewModel(renderType: .comments(comments: comments)),
                actions: PostRenderViewModel(renderType: .actions(provide: ""))
            )
            feedRenderModels.append(viewModel)
        }
    }
    
    private func handleNotAuthenticated() {
        // check auth status
        if Auth.auth().currentUser == nil {
            // show login
            let loginVC = LoginViewController()
            loginVC.modalPresentationStyle = .fullScreen
            present(loginVC, animated: true)
        }
    }
}


extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return feedRenderModels.count * 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let x = section
        var model: HomeFeedRenderViewType
        if x == 0 {
            model = feedRenderModels[0]
        } else {
            let position = x % 4 == 0 ? x / 4 : (x - ( x % 4)) / 4
            model = feedRenderModels[position]
        }
        
        let subSection = x % 4
        
        if subSection == 0 {
            // header
            return 1
        } else if subSection == 1 {
            // post
            return 1
        } else if subSection == 2 {
            // actions
            return 1
        } else { //  if subSection == 3
            // comments
            let commentsModel = model.comments
            switch commentsModel.renderType {
            case .comments(let comments): return comments.count > 2 ? 2 : comments.count
            case .actions, .header, .primaryCount: return 0
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let x = indexPath.section
        var model: HomeFeedRenderViewType
        if x == 0 {
            model = feedRenderModels[0]
        } else {
            let position = x % 4 == 0 ? x / 4 : (x - ( x % 4)) / 4
            model = feedRenderModels[position]
            print(model)
        }
        
        let subSection = x % 4
        
        if subSection == 0 {
            // header
            let headerModel = model.header
            
            switch headerModel.renderType {
            case .header(let user):
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: ZLFeedPostHeaderTableViewCell.identifier,
                    for: indexPath
                ) as! ZLFeedPostHeaderTableViewCell
                return cell
            case .actions, .comments, .primaryCount: return UITableViewCell()
            }
            
        } else if subSection == 1 {
            // post
            let postModel = model.post
           
            switch postModel.renderType {
            case .primaryCount(let post):
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: ZLFeedPostGenaeralTableViewCell.identifier,
                    for: indexPath
                ) as! ZLFeedPostGenaeralTableViewCell
                return cell
            case .actions, .comments, .header: return UITableViewCell()
            }
            
        } else if subSection == 2 {
            
            // actions
            let actionsModel = model.actions
            
            switch actionsModel.renderType {
            case .actions(let provider):
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: ZLFeedPostActionsTableViewCell.identifier,
                    for: indexPath
                ) as! ZLFeedPostActionsTableViewCell
                return cell
            case .primaryCount, .comments, .header: return UITableViewCell()
            }
            
        } else { // if subSection == 3
            // comments
            let commentsModel = model.comments
            switch commentsModel.renderType {
            case .comments(let comments):
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: ZLFeedPostTableViewCell.identifier,
                    for: indexPath
                ) as! ZLFeedPostTableViewCell
                return cell
            case .primaryCount, .actions, .header: return UITableViewCell()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let subSection = indexPath.section % 4
        
        if subSection == 0 {
            return CGFloat(70)
        } else if subSection == 1 {
            return tableView.width
        } else if subSection == 2 {
            return CGFloat(60)
        } else  { // if subSection == 3
            return CGFloat(50)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 { return 0 }
        return section % 3 == 0 ? 70 : 0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    
    
}
