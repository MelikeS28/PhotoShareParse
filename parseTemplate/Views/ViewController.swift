//
//  ViewController.swift
//  parseTemplate
//
//  Created by Melike on 28.03.2025.
//

import UIKit

class ViewController: UIViewController {
    
// MARK: - IBOutlets
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
// MARK: - Properties
    
    private let viewModel = AuthViewModel()
    
// MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        setupGesture()

    }
// MARK: - Setup Bindings & Gestures
    
    private func setupBindings() {
        
        viewModel.didSuccess = { [weak self] in
            DispatchQueue.main.async {
                self?.performSegue(withIdentifier: "toTabbar", sender: nil)
            }
        }
        
        viewModel.didFailure = { [weak self] errorMessage in
            guard let self = self else { return }
            AlertManager.showAlert(on: self, title: "Error", message: errorMessage)
        }

    }
    
    private func setupGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func hideKeyboard() {
            view.endEditing(true)
    }
    
// MARK: - Actions
    
    @IBAction func logInButton(_ sender: Any) {
        viewModel.logIn(username: userNameTextField.text, password: passwordTextField.text)
    }
    
    @IBAction func singUpButton(_ sender: Any) {
        viewModel.signUp(username: userNameTextField.text, password: passwordTextField.text)
    }
    
}

