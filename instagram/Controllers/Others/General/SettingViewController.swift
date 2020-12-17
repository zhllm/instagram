//
//  SettingViewController.swift
//  instagram
//
//  Created by 张杰 on 2020/12/16.
//

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
        let section = [
            SettingModel(title: "Log out") {[weak self] in
                self?.didTapLoginout()
            }
        ]
        data.append(section)
    }
    
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
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        data[indexPath.section][indexPath.row].handler()
    }
    
    
}
