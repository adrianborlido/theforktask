//
//  AggregateRating.swift
//  TheForkTask
//
//  Created by Adrian Borlido on 7/5/22.
//

import Foundation

struct AggregateRating: Codable {
    let thefork: Rating?
    let tripadvisor: Rating?
    
    enum CodingKeys: String, CodingKey {
        case thefork, tripadvisor
    }
}
