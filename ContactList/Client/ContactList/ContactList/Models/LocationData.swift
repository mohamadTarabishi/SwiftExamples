//
//  Location.swift
//  ContactList
//
//  Created by Andrea Prearo on 7/9/19.
//  Copyright © 2019 Andrea Prearo. All rights reserved.
//

import Foundation

enum LocationDataError: Error {
    case failedParsing
}

struct LocationData: Codable {
    let label: String?
    let location: Location?

    // MARK: - Decodable

    init(from decoder: Decoder) throws {
        guard let container = try? decoder.singleValueContainer(),
            let locationDataFromContainer = try? container.decode([String: Location].self),
            locationDataFromContainer.count == 1,
            let locationData = try? container.decode([String: Location].self).first else {
            throw LocationDataError.failedParsing
        }
        label = locationData.key
        location = locationData.value
    }
}
