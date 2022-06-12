
//  Helper+Ext.swift
//  Thirdwayv.inc-Task
//
//  Created by Abdalah on 10/06/2022.
//


import Foundation
import UIKit
import Network
import SystemConfiguration
extension  UIViewController {
    
    /// AlertController An action that can be show message  in an alert.
    /// - Parameter message: message description what need to show it
    func showAlert( _ message: String ) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alert.addAction( UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
   
}

