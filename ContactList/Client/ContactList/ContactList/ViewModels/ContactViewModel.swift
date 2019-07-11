//
//  ContactViewModel.swift
//  ContactList
//
//  Created by Andrea Prearo on 7/9/19.
//  Copyright © 2019 Andrea Prearo. All rights reserved.
//

import Foundation

class ContactViewModel {
    let avatarUrl: String?
    let username: String
    let company: String

    init(contact: Contact) {
        // Avatar
        if let url = contact.avatar {
            avatarUrl = url
        } else {
            avatarUrl = nil
        }

        // Username
        username = contact.fullName

        // Company
        company = contact.company ?? ""
    }    
}
