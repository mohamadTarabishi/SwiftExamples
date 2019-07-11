//
//  UIViewController+Util.swift
//  ContactList
//
//  Created by Andrea Prearo on 7/9/19.
//  Copyright © 2019 Andrea Prearo. All rights reserved.
//

import UIKit

extension UIViewController {
    func showError(_ title: String, message: String) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        present(alertController, animated: true, completion: nil)
    }    
}
