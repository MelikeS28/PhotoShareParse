//
//  AlertManager.swift
//  parseTemplate
//
//  Created by Melike on 15.07.2026.
//

import Foundation
import UIKit

final class AlertManager {
    
    static func showAlert(on VC: UIViewController, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(alertAction)
        
        
        if Thread.isMainThread {
            VC.present(alert, animated: true, completion: nil)
        } else {
            DispatchQueue.main.async {
                VC.present(alert, animated: true, completion: nil)
            }
        }
    }
    
}
