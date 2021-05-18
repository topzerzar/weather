//
//  BaseViewController.swift
//  KrugsriWeather
//
//  Created by weerapon on 17/5/2564 BE.
//

import UIKit

class BaseViewController: UIViewController, BaseView {
    
    func startLoading() {
        
    }
    
    func stopLoading() {
        
    }
    
    func alertDialog(title: String, message: String, callback: ((UIAlertAction) -> Void)? = nil) {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
            
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: callback)
        alertController.addAction(OKAction)

        self.present(alertController, animated: true, completion: nil)
    }
    
}
