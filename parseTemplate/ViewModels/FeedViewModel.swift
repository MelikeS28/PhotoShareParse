//
//  FeedViewModel.swift
//  parseTemplate
//
//  Created by Melike on 20.07.2026.
//

import Foundation


//MARK: - Protocol

protocol FeedViewModelOutput : AnyObject {
    func reloadData()
    func showError(message: String)
}

final class FeedViewModel {
    
    private let parseService: ParseService
    
    private(set) var posts : [Post] = []
    
    weak var delegate: FeedViewModelOutput?
    
    init(parseService: ParseService = ParseService()) {
        self.parseService = parseService
    }
    
    func fetchPosts() {
        parseService.fetchPosts { [weak self] result in
            switch result {
            case .success(let fechedPost):
                self?.posts = fechedPost
                self?.delegate?.reloadData()
            case .failure(let error):
                self?.delegate?.showError(message: error.localizedDescription)
            }
        }
    }
    
}
