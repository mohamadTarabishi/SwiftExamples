//
//  ContactsViewController.swift
//  ContactList
//
//  Created by Andrea Prearo on 7/9/19.
//  Copyright © 2019 Andrea Prearo. All rights reserved.
//

import UIKit

class ContactsViewController: UITableViewController {
    lazy var contactsController = ContactsController(persistentContainer: coreDataStack.storeContainer)

    var coreDataStack: CoreDataStack!

    override func viewDidLoad() {
        super.viewDidLoad()

        contactsController.fetchItems { [weak self] (success, error) in
            guard let self = self else { return }
            if !success {
                DispatchQueue.main.async {
                    let title = "Error"
                    if let error = error {
                        self.showError(title, message: error.localizedDescription)
                    } else {
                        self.showError(title, message: "Can't retrieve contacts.")
                    }
                }
            } else {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
}
