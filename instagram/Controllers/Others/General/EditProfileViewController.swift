//
//  EditProfileViewController.swift
//  instagram
//
//  Created by 张杰 on 2020/12/16.
//

import UIKit

struct EditProfileFormModel {
    let label: String
    let placeholder: String
    var value: String?
    
}


final class EditProfileViewController: UIViewController, FromTableViewCellDelegate {
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(FromTableViewCell.self, forCellReuseIdentifier: FromTableViewCell.identifier)
        return table
    }()
    
    private var models = [[EditProfileFormModel]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        configureModels()
        
        view.addSubview(tableView)
        tableView.tableHeaderView = createTableHeaderView()
        tableView.dataSource = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(didTapSave))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(didTapCancel))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    
    public func configureModels() {
        // name, username, website, bio
        let section1Labels = ["Name", "username", "bio"]
        var section1 = [EditProfileFormModel]()
        for label in section1Labels {
            let model = EditProfileFormModel(label: label,
                                             placeholder: "Enter \(label)...",
                                             value: nil)
            section1.append(model)
        }
        models.append(section1)
        // email, phone, gender
        let section2Labels = ["email", "phone", "gender"]
        var section2 = [EditProfileFormModel]()
        for label in section2Labels {
            let model = EditProfileFormModel(label: label,
                                             placeholder: "Enter \(label)...",
                                             value: nil)
            section2.append(model)
        }
        models.append(section2)
    }
    
    @objc private func didTapSave() {
        // save to database
        
    }
    
    @objc private func didTapCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func didTapChangeProfilePicture() {
        let actionSheet = UIAlertController(title: "Profle Picture",
                                            message: "Change proile picture",
                                            preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Take Photo", style: .default, handler: { (_) in
            
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Choose from Library", style: .default, handler: { (_) in
            
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        actionSheet.popoverPresentationController?.sourceView = view
        actionSheet.popoverPresentationController?.sourceRect = view.bounds
        
        present(actionSheet, animated: true, completion: nil)
    }
    
}

extension EditProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.section][indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: FromTableViewCell.identifier,
                                                 for: indexPath) as! FromTableViewCell
        cell.configure(model: model)
        cell.delegate = self
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    
    //    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
    //        guard section == 1 else {
    //            return nil
    //        }
    //        return "Private Information"
    //    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard section == 1 else {
            return nil
        }
        return "Private Information"
    }
    
    func createTableHeaderView() -> UIView {
        // CGRect integral 返回最小整数的矩形
        let header = UIView(frame: CGRect(x: 0,
                                          y: 0,
                                          width: self.view.width,
                                          height: view.height / 4).integral)
        let size = header.height / 1.5
        let profilePhotoButton = UIButton(frame: CGRect(x: (header.width - size) / 2,
                                                        y: (header.height - size) / 2,
                                                        width: size,
                                                        height: size))
        header.addSubview(profilePhotoButton)
        profilePhotoButton.layer.masksToBounds = true
        profilePhotoButton.layer.cornerRadius = size / 2.0
        profilePhotoButton.addTarget(self,
                                     action: #selector(didTapProfileButton),
                                     for: .touchUpInside)
        profilePhotoButton.setBackgroundImage(UIImage(systemName: "person.circle"),
                                              for: .normal)
        profilePhotoButton.tintColor = .label
        profilePhotoButton.layer.borderWidth = 1
        profilePhotoButton.layer.borderColor = UIColor.secondarySystemBackground.cgColor
        return header
    }
    
    func fromTableViewCell(_ cell: FromTableViewCell, didUpdateField updateModel: EditProfileFormModel) {
        print("\(updateModel.label)")
    }
    
    @objc private func didTapProfileButton() {
        
    }
    
}
