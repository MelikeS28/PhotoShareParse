//
//  AuthViewModel.swift
//  parseTemplate
//
//  Created by Melike on 22.07.2026.
//

import Foundation

final class AuthViewModel {
    
// MARK: - Properties
    
    private let parseService: ParseService
    
    var isLoading: ((Bool) -> Void)?
    var didSuccess: (() -> Void)?
    var didFailure: ((String) -> Void)?
    
    init(parseService: ParseService = ParseService.shared) {
        self.parseService = parseService
    }
    
// MARK: - Auth Actions
    
    func logIn(username: String?, password: String?) {
        
        guard let username = username, !username.isEmpty,
              let password = password, !password.isEmpty else {
                  self.didFailure?("Please enter a username and password!")
                  return
              }
        
        isLoading?(true)
        
        parseService.login(username: username, password: password) { [weak self] success, error in
            self?.isLoading?(false)
            
            if success {
                self?.didSuccess?()
            } else {
                let message = error?.localizedDescription ?? "An error occurred while logging in."
                self?.didFailure?(message)
            }
        }
    }
    
    func signUp(username: String?, password: String?) {
        guard let username = username, !username.isEmpty,
              let password = password, !password.isEmpty else {
            self.didFailure?("Please enter a username and password!")
            return
        }
        
        isLoading?(true)
        
        parseService.signUp(username: username, password: password) { [weak self] success, error in
            
            self?.isLoading?(false)
            
            if success {
                self?.didSuccess?()
            } else {
                let message = error?.localizedDescription ?? "An error occurred while signing up."
                self?.didFailure?(message)
            }
        }
    }
    
}
