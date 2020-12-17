//
//  SettingViewController.swift
//  instagram
//
//  Created by 张杰 on 2020/12/16.
//

import SafariServices
import UIKit

struct SettingModel {
    let title: String
    let handler: (() -> Void)
}

/// ViewController to show User setting
final class SettingViewController: UIViewController {
    
    private let talbeView: UITableView = {
        let table = UITableView(
            frame: .zero,
            style: .grouped
        )
        table.register(UITableViewCell.self,
                       forCellReuseIdentifier: "cell")
        return table
    }()
    
    private var data = [[SettingModel]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureModels()
        view.backgroundColor = .systemBackground
        view.addSubview(self.talbeView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        talbeView.frame = view.bounds
        talbeView.delegate = self
        talbeView.dataSource = self
    }
    
    private func configureModels() {
        data.append([
            SettingModel(title: "Edit Profile") {[weak self] in
                guard let weakSelf = self else {
                    return
                }
                weakSelf.didTapEditProfile()
            },
            SettingModel(title: "Invite Friends") {[weak self] in
                guard let weakSelf = self else {
                    return
                }
                weakSelf.didTapInviteFriends()
            },
            SettingModel(title: "Save Original Posts") {[weak self] in
                guard let weakSelf = self else {
                    return
                }
                weakSelf.didTapSaveOriginalPosts();
            }
        ])
        
        data.append([
            SettingModel(title: "Terms of Service") {[weak self] in
                guard let weakSelf = self else {
                    return
                }
                weakSelf.openURL(type: .terms)
            },
            SettingModel(title: "Privacy Policy") {[weak self] in
                guard let weakSelf = self else {
                    return
                }
                weakSelf.openURL(type: .privacy)
            },
            SettingModel(title: "Help / Feedback") {[weak self] in
                guard let weakSelf = self else {
                    return
                }
                weakSelf.openURL(type: .help)
            },
        ])
        
        data.append([
            SettingModel(title: "Log out") {[weak self] in
                self?.didTapLoginout()
            }
        ])
    }
}


// MRK: - setting button callback
extension SettingViewController{
    
    enum SettingURLType {
        case terms, privacy, help
    }
    
    // layout button to user lay out
    func didTapLoginout() {
        let actionSheet = UIAlertController(title: "Log out",
                                            message: "Are you sure you want to log out?",
                                            preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Cancel",
                                            style: .cancel, handler: nil))
        actionSheet.addAction(UIAlertAction(title: "Log out",style: .destructive, handler: { (_) in
            AuthManager.shared.logout { [weak self] (logoutSuccess) in
                guard let weakSelf = self else {
                    return
                }
                DispatchQueue.main.async {
                    if logoutSuccess {
                        // log out success
                        let loginVC = LoginViewController()
                        loginVC.modalPresentationStyle = .fullScreen
                        weakSelf.present(loginVC, animated: true) {
                            weakSelf.navigationController?.popToRootViewController(animated: true)
                            weakSelf.tabBarController?.selectedIndex = 0
                        }
                        return
                    } else {
                        // log out failure
                        fatalError("Can't log out User")
                    }
                }
            }
        }))
        actionSheet.popoverPresentationController?.sourceView = talbeView
        actionSheet.popoverPresentationController?.sourceRect = talbeView.bounds
        present(actionSheet, animated: true, completion: nil)
    }
    
    func didTapEditProfile () {
        let vc = EditProfileViewController()
        vc.title = "Edit Profile"
        let navVC = UINavigationController(rootViewController: vc)
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true, completion: nil)
    }
    
    func didTapInviteFriends() {
        // share show sheet to invite friends
    }
    
    func didTapSaveOriginalPosts() {
        
    }
    
    func openURL(type: SettingURLType) {
        let urlString: String
        switch type {
        case .help: urlString = "https://help.instagram.com/"
        case .privacy: urlString = "https://help.instagram.com/519522125107875"
        case .terms: urlString = "https://www.facebook.com/help/instagram/termsofuse"
        }
        
        guard let url = URL(string: urlString) else {
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true, completion: nil)
    }
}


extension SettingViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = talbeView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.section][indexPath.row].title
        // 右侧有个向右的箭头
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        data[indexPath.section][indexPath.row].handler()
    }
    
    
}
