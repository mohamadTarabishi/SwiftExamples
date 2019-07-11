//
//  Contact.swift
//  ContactList
//
//  Created by Andrea Prearo on 7/9/19.
//  Copyright © 2019 Andrea Prearo. All rights reserved.
//

import Foundation

struct Contact: Codable {
    enum CodingKeys: String, CodingKey {
        case avatar
        case firstName
        case lastName
        case company
        case hireDate
        case phone
        case email
        case location
    }

    let avatar: String?
    let firstName: String?
    let lastName: String?
    let hireDate: Date?
    let company: String?
    let phone: [PhoneData]?
    let email: [EmailData]?
    let location: [LocationData]?

    // MARK: - Decoding Helpers

    static func decode(from jsonData: Data) throws -> [Contact]? {
        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYY-MM-DD"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode([Contact].self, from: jsonData)
    }
}

// MARK: - Helpers

extension Contact {
    var fullName: String {
        let first = firstName ?? ""
        let last = lastName ?? ""
        return "\(first) \(last)"
    }

//    var address: String {
//        let firstLocation = location?.first
//        if let location = firstLocation,
//            let data = location.data {
//            let city = data.city ?? ""
//            let state = data.state ?? ""
//            return "\(city), \(state)"
//        } else {
//            return ", "
//        }
//    }
}
