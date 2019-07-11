//
//  EmailData.swift
//  ContactList
//
//  Created by Andrea Prearo on 7/9/19.
//  Copyright © 2019 Andrea Prearo. All rights reserved.
//

import Foundation

typealias Email = String

enum EmailDataError: Error {
    case failedParsing
}

struct EmailData: Codable {
    let label: String?
    let address: String?
    // MARK: - Decodable
    
    init(from decoder: Decoder) throws {
        guard let container = try? decoder.singleValueContainer(),
            let emaiDataFromContainer = try? container.decode([String: Phone].self),
            emaiDataFromContainer.count == 1,
            let emailData = try? container.decode([String: Phone].self).first else {
                throw PhoneDataError.failedParsing
        }
        label = emailData.key
        address = emailData.value
    }
}
