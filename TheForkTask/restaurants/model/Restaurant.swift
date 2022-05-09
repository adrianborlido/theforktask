//
//  Restaurant.swift
//  TheForkTask
//
//  Created by Adrian Borlido on 7/5/22.
//

import Foundation

struct Restaurant: Codable {
    let name: String?
    let uuid: String?
    let mainPhoto: MainPhoto?
    let aggregateRating: AggregateRating?
    let address: Address?
    
    enum CodingKeys: String, CodingKey {
        case name, uuid, mainPhoto, address
        case aggregateRating = "aggregateRatings"
    }
}
