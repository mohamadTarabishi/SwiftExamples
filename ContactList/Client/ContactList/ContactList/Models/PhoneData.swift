//
//  PhoneData.swift
//  ContactList
//
//  Created by Andrea Prearo on 7/9/19.
//  Copyright © 2019 Andrea Prearo. All rights reserved.
//

import Foundation

typealias Phone = String

enum PhoneDataError: Error {
    case failedParsing
}

struct PhoneData: Codable {
    let label: String?
    let number: String?

    // MARK: - Decodable

    init(from decoder: Decoder) throws {
        guard let container = try? decoder.singleValueContainer(),
            let phoneDataFromContainer = try? container.decode([String: Phone].self),
            phoneDataFromContainer.count == 1,
            let phoneData = try? container.decode([String: Phone].self).first else {
            throw PhoneDataError.failedParsing
        }
        label = phoneData.key
        number = phoneData.value
    }
}
