//
//  Rating.swift
//  TheForkTask
//
//  Created by Adrian Borlido on 7/5/22.
//

import Foundation

struct Rating: Codable {
    let ratingValue: Double?
    let reviewCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case ratingValue, reviewCount
    }
}
