//
//  Location.swift
//  ContactList
//
//  Created by Andrea Prearo on 7/9/19.
//  Copyright © 2019 Andrea Prearo. All rights reserved.
//

import Foundation

struct Location: Codable {
    enum CodingKeys: String, CodingKey {
        case address
        case city
        case state
        case country
        case zipCode
    }

    let address: String?
    let city: String?
    let state: String?
    let country: String?
    let zipCode: String?
}
