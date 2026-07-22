//
//  UploadViewController.swift
//  parseTemplate
//
//  Created by Melike on 3.04.2025.
//

import UIKit

final class UploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
 
    // MARK: - IBOutlets
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var shareButton: UIButton!
    
    
    // MARK: - Properties
    
    private let viewModel = UploadViewModel()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gestureRecognizers()
        setupViewModelBindings()
        
        shareButton.isEnabled = false
    }
    
    // MARK: - Gesture Recognizer
    private func gestureRecognizers() {
        
        let keyboardRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        keyboardRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(keyboardRecognizer)
        commentTextField.isUserInteractionEnabled = true
        
        imageView.isUserInteractionEnabled = true
        
        let imageGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        imageView.addGestureRecognizer(imageGestureRecognizer)
    
        
    }
    
    // MARK: - Setup Bindings
    
    private func setupViewModelBindings() {
        
        viewModel.isLoading = { [weak self] isLoading in
            DispatchQueue.main.async {
                self?.shareButton.isEnabled = !isLoading
                
            }
        }
        
        viewModel.didSuccess = { [weak self] in
            guard let self = self else { return }
            
            AlertManager.showAlert(on: self, title: "Success", message: "Your post shared successfully!")
            
            self.commentTextField.text = ""
            self.imageView.image = UIImage(named: "imagee")
            self.shareButton.isEnabled = false
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "newPOST"), object: nil)
            
            tabBarController?.selectedIndex = 0
        }
        
        viewModel.didFailure = { [weak self] errorMessage in
            guard let self = self else { return }
            AlertManager.showAlert(on: self, title: "Error", message: errorMessage)
        }
    
    }
 
    // MARK: - Actions
    
    @objc func hideKeyboard(){
        view.endEditing(true)
    }
    @objc func chooseImage(){
            let pickerController = UIImagePickerController()
            pickerController.delegate = self
            pickerController.sourceType = .photoLibrary
            present(pickerController, animated: true, completion: nil)
    }
   
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        shareButton.isEnabled = true
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func shareImageButton(_ sender: Any) {
        viewModel.upload(image: imageView.image, comment: commentTextField.text)
    }
    
}
