//
//  SettingsViewController.swift
//  parseTemplate
//
//  Created by Melike on 6.04.2025.
//

import UIKit

final class SettingsViewController: UIViewController {

// MARK: - Properties
    
    private let viewModel = SettingsViewModel()
    
// MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
    }
    
// MARK: - Setup Bindings
    
    private func setupBindings() {
        
        viewModel.didSuccessLogout = { [weak self] in
            DispatchQueue.main.async {
                self?.performSegue(withIdentifier: "toVC", sender: nil)
            }
        }
        
        viewModel.didFailure = { [weak self] errorMessage in
            guard let self else { return }
            AlertManager.showAlert(on: self, title: "Error", message: errorMessage)
        }
    
    }
    
// MARK: - Actions
    
    @IBAction func logOutClicked(_ sender: Any) {
        viewModel.logout()
    }
    
}
