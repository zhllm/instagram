//
//  AuthManaget.swift
//  instagram
//
//  Created by 张杰 on 2020/12/16.
//
import FirebaseAuth

public class AuthManager {
    static let shared = AuthManager()
    
    // MARK: - Public
    public func registerUser(username:String, email: String, password: String, complete: @escaping (Bool) -> ()) {
        /**
            - check if username is available
            - check if password is available
            - check if emai is available
         */
        DatabaseManager.shared.canCreateUser(with: username, username: email) { (success) in
            if success {
                // - create an account
                // - insert account to database
                Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
                    guard error == nil, authResult != nil else {
                        print("-------------createUser error:------------- \(String(describing: error))")
                        complete(false)
                        return
                    }
                    DatabaseManager.shared.insertNewUser(with: email, username: username) { (success) in
                        if success {
                            complete(true)
                            return
                        } else {
                            complete(false)
                            return
                        }
                    }
                }
            } else {
                complete(false)
            }
        }
    }
    
    public func loginUser(username: String?, email: String?, password: String, complete: @escaping ((Bool) -> ()) ) {
        if let email = email {
            // email login
            Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
                guard let _ = authResult, error == nil else {
                    complete(false)
                    return
                }
                complete(true)
            }
        } else if let username = username {
            // username login
            print(username)
        }
    }
    
    public func logout(completion: @escaping (Bool) -> ()) {
        do {
            try Auth.auth().signOut()
            completion(true)
            return
        } catch let error {
            completion(false)
            print("------log out error ------- \(error)")
            return
        }
    }
}

