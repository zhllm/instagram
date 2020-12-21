//
//  DatabaseManager.swift
//  instagram
//
//  Created by 张杰 on 2020/12/16.
//

import FirebaseDatabase

public class DatabaseManager {
    static let shared = DatabaseManager()
    
    private let  database = Database.database().reference()
    
    // MARK: - Public
    
    
    ///  checke username emai is available
    /// - Parameters:
    ///   - email: String representing email
    ///   - username: String representing username
    public func canCreateUser(with email: String, username: String, complete: @escaping (Bool) -> ()) {
        complete(true)
    }
    
    
    /// insert a new account to database
    /// - Parameters:
    ///   - email: String representing email
    ///   - username: String representing username
    public func insertNewUser(with email: String, username: String, complete: @escaping (Bool) -> ()) {
        database.child(email.safaDatabaseKey()).setValue(["username":username]) { (error, _) in
            if error == nil {
                complete(true)
                return
            }else {
                complete(false)
                return
            }
        }
    }
    
//    private func safeKey() {
//        
//    }
}
