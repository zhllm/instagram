//
//  PostViewController.swift
//  instagram
//
//  Created by 张杰 on 2020/12/16.
//

import UIKit

enum PostRenderType {
    case header(provider: User)
    case primaryCount(provide: UserPost)
    case actions(provide: String) // like comments share
    case comments(comments: [PostComment])
}

struct PostRenderViewModel {
    let renderType: PostRenderType
}

class PostViewController: UIViewController {
    
    private var model: UserPost?
    
    private var renderModels = [PostRenderViewModel]()
    
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
    
    
    
    init(model: UserPost?) {
        super.init(nibName: nil, bundle: nil)
        self.model = model
        configureModels()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureModels() {
        guard let userPostModel = model else {
            return
        }
        // Header
        renderModels.append(PostRenderViewModel(renderType: .header(provider: userPostModel.owner)))
        // Post
        renderModels.append(PostRenderViewModel(renderType: .primaryCount(provide: userPostModel)))
        // Actions
        renderModels.append(PostRenderViewModel(renderType: .actions(provide: "")))
        // Comments
        var comments = [PostComment]()
        for x in 0..<4 {
            comments.append(
                PostComment(
                    identifier: "123_\(x)",
                    username: "@Jay",
                    text: "Great Post!",
                    createDate: Date(),
                    likes: [])
            )
        }
        renderModels.append(PostRenderViewModel(renderType: .comments(comments: comments)))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        view.backgroundColor = .systemBackground
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }

}

/// extensions UItableVIew
extension PostViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return renderModels.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch renderModels[section].renderType {
        case .actions(_): return 1
        case .comments(comments: let comments): return comments.count > 4 ? 4 : comments.count
        case .header(_): return 1
        case .primaryCount(_): return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = renderModels[indexPath.section]
        switch model.renderType {
        case .actions(let actions):
            let cell = tableView.dequeueReusableCell(
                withIdentifier: ZLFeedPostActionsTableViewCell.identifier,
                for: indexPath
            ) as! ZLFeedPostActionsTableViewCell
            return cell
        case .primaryCount(let post):
            let cell = tableView.dequeueReusableCell(
                withIdentifier: ZLFeedPostGenaeralTableViewCell.identifier,
                for: indexPath
            ) as! ZLFeedPostGenaeralTableViewCell
            return cell
        case .comments(let comments):
            let cell = tableView.dequeueReusableCell(
                withIdentifier: ZLFeedPostTableViewCell.identifier,
                for: indexPath
            ) as! ZLFeedPostTableViewCell
            return cell
        case .header(let user):
            let cell = tableView.dequeueReusableCell(
                withIdentifier: ZLFeedPostHeaderTableViewCell.identifier,
                for: indexPath
            ) as! ZLFeedPostHeaderTableViewCell
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = renderModels[indexPath.section]
        switch model.renderType {
        case .actions(_): return 60
        case .comments(_): return 50
        case .primaryCount(_): return tableView.width
        case .header(_): return 70
        }
    }
    
}
