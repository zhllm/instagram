//
//  NotificationViewController.swift
//  instagram
//
//  Created by 张杰 on 2020/12/16.
//

import UIKit

enum UserNotificationType {
    case like(post: UserPost)
    case follow(state: FollowState)
}

struct UserNotification {
    let type: UserNotificationType
    let text: String
    let user: User
}

final class NotificationViewController: UIViewController {
    
    private lazy var noNotificationView = NoNotificationView()
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = false
        spinner.tintColor = .label
        return spinner
    }()
    
    private let tableView: UITableView = {
        let table = UITableView()
        // table.isHidden = true
        table.register(NotificationLikeEventTableViewCell.self,
                       forCellReuseIdentifier: NotificationLikeEventTableViewCell.identifier)
        table.register(NotificationFollowEventTableViewCell.self,
                       forCellReuseIdentifier: NotificationFollowEventTableViewCell.identifier)
        return table
    }()
    
    private var models = [UserNotification]()
    
    // MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchNotifications()
        navigationItem.title = "Notification"
        view.backgroundColor = .systemBackground
        view.addSubview(spinner)
        // spinner.startAnimating()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(noNotificationView)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        spinner.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        spinner.center = view.center
        // layoutNoNotificationsView()
    }
    
    private func layoutNoNotificationsView() {
        // tableView.isHidden = true
        noNotificationView.frame = CGRect(x: 0, y: 0, width: view.width / 2, height: view.width / 2)
        noNotificationView.center = view.center
    }
    
    private func fetchNotifications() {
        for x in 0..<100 {
            models.append(
                UserNotification(
                    type: x % 2 == 0 ? .like(
                        post: UserPost(
                            identifier: "",
                            postType: .photo,
                            thumbnailImage: URL(string:"https://www.google.com")!,
                            postURL: URL(string: "https://www.google.com")!,
                            caption: nil,
                            likeCount: [],
                            comments: [],
                            createDate: Date(),
                            taggeUsers: [])
                    ) : .follow(state: .not_following),
                    text: "Hello world",
                    user: User(
                        username: "Joe",
                        bio: "",
                        name: (first: "String", last: "String"),
                        birthDate: Date(),
                        gender: .female,
                        counts: UserCount(followers: 10, following: 10, posts: 10),
                        profilePhoto: URL(string: "https://www.google.com")!,
                        joinDate: Date()
                    )
                )
            )
        }
    }
    
}


extension NotificationViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        switch model.type {
        case .follow:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: NotificationFollowEventTableViewCell.identifier,
                for: indexPath
            ) as! NotificationFollowEventTableViewCell
            cell.delegate = self
            cell.configure(with: model)
            return cell
        case .like(post: _):
            let cell = tableView.dequeueReusableCell(
                withIdentifier: NotificationLikeEventTableViewCell.identifier,
                for: indexPath
            ) as! NotificationLikeEventTableViewCell
            cell.configure(with: model)
            cell.delegate = self
            return cell
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 52
    }
    
}

extension NotificationViewController: NotificationLikeEventTableViewCellDelegate {
    func didTapRelatedPostButton(model: UserNotification) {
        print("didTapRelatedPostButton")
    }
}

extension NotificationViewController: NotificationFollowEventTableViewCellDelegate {
    func didTapFollowunFollowButton(model: UserNotification) {
        print("didTapFollowunFollowButton")
    }
    
    
}
