//
//  StorageManager.swift
//  instagram
//
//  Created by 张杰 on 2020/12/16.
//

import FirebaseStorage


public class StorageManager {
    static let shared = StorageManager()
    private let bucket = Storage.storage().reference()
    
    public enum ZLStorageMessageError: Error {
        case failedDownload
    }
    
    // MARK: - Public
    public func uploadUserPost(model: UserPost, result: @escaping (Result<URL, Error>) -> Void) {
        
    }
    
    public func downloadImage(with reference: String, completion: @escaping (Result<URL, ZLStorageMessageError>) -> Void) {
        bucket.child(reference).downloadURL { (url, error) in
            guard let url = url, error == nil else {
                print("---------downloadURL error \(String(describing: error))----------")
                completion(.failure(.failedDownload))
                return
            }
            completion(.success(url))
            
        }
    }
}
