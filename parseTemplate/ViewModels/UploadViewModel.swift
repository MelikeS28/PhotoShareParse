//
//  UploadViewModel.swift
//  parseTemplate
//
//  Created by Melike on 17.07.2026.
//

import Foundation
import UIKit

class UploadViewModel {
    var isLoading: ((Bool) -> Void)?
    var didSuccess: (() -> Void)?
    var didFailure: ((String) -> Void)?
    
    func upload(image: UIImage?, comment: String?) {
        guard let selectedImage = image else {
            self.didFailure?("Please choose an image")
            return
        }
        
        let postComment = comment ?? ""
        
        self.isLoading?(true)
        
        ParseService.shared.uploadPost(image: selectedImage, comment: postComment) { [weak self] success, error in
            
            guard let self = self else { return }
            
            self.isLoading?(false)
            
            if success {
                self.didSuccess?()
            } else {
                let errorMessage = error?.localizedDescription ?? "An unknown error occurred."
                self.didFailure?(errorMessage)
            }
        }
    }
    
}
