//
//  ParseService.swift
//  parseTemplate
//
//  Created by Melike on 15.07.2026.
//

import Foundation
import Parse
import UIKit

final class ParseService {
    
    static let shared = ParseService()
    init() {}
    
 //MARK: - LOGOUT
    
    func logOut(completion: @escaping (Error?) -> Void) {
        PFUser.logOutInBackground() { error in
            completion(error)
        }
    }
    
//MARK: - UPLOAD
    
    func uploadPost(image: UIImage, comment: String, completion: @escaping (Bool, Error?) -> Void) {
        guard let currentUser = PFUser.current(), let userName = currentUser.username else {
            completion(false, NSError(domain: "AuthError", code: 401, userInfo: [NSLocalizedDescriptionKey: "No authenticated user found."]))
            return
        }
        
        guard let imageData = image.jpegData(compressionQuality: 0.5) else {
            completion(false, NSError(domain: "ImageError", code: 400, userInfo: [NSLocalizedDescriptionKey: "Failed to process image."]))
            return
        }
        
        let parseImage = PFFileObject(name: "image.jpg", data: imageData)
        let post = PFObject(className: "Post")
        post["postImage"] = parseImage
        post["postComment"] = comment
        post["postOwner"] = userName
        
        post.saveInBackground { success, error in
            completion(success, error)
        }
        
    }
    
//MARK: - FETCH
    
    func fetchPosts(completion:  @escaping(Result<[Post],Error>) -> Void) {
        
        let query = PFQuery(className: "Post")
        query.addAscendingOrder("createdAt")
        
        query.findObjectsInBackground() { objects, error in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let objects = objects else {
                completion(.success([]))
                return
            }
            
            let fetchedPosts = objects.compactMap { object -> Post? in
                guard let userName = object.object(forKey: "postOwner") as? String, let userImage = object.object(forKey: "postImage") as? PFFileObject else {
                    return nil
                }
                
                let userComment = object.object(forKey: "postComment") as? String ?? ""
                return Post(userName: userName, userComment: userComment, userImage: userImage)
            }
            completion(.success(fetchedPosts))
        }
    }
    
//MARK: - LOGIN/SIGN UP
    
    func login(username: String, password: String, completion: @escaping(Bool, Error?) -> Void) {
        PFUser.logInWithUsername(inBackground: username, password: password) { user, error in
            if let error = error {
                completion(false, error)
            } else {
                completion(true, nil)
            }
        }
    }
    
    func signUp(username: String, password: String, completion: @escaping(Bool, Error?) -> Void) {
        let user = PFUser()
        user.username = username
        user.password = password
        
        user.signUpInBackground() { success, error in
            completion(success, error)
        }
    }
    
}

