//
//  SettingsViewModel.swift
//  parseTemplate
//
//  Created by Melike on 22.07.2026.
//

import Foundation

final class SettingsViewModel {
    
    private let parseService: ParseService
    
    var didSuccessLogout : (() -> Void)?
    var didFailure : ((String) -> Void)?
    
    init(parseService: ParseService = ParseService.shared) {
        self.parseService = parseService
    }
    
    func logout() {
        parseService.logOut { [weak self] error in
            
            if let error = error {
                let message = error.localizedDescription
                self?.didFailure?(message)
            } else {
                self?.didSuccessLogout?()
            }
        }
    }
    
    
}
