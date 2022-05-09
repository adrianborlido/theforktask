//
//  Address.swift
//  TheForkTask
//
//  Created by Adrian Borlido on 7/5/22.
//

import Foundation

struct Address: Codable {
    let street: String?
    let postalCode: String?
    let locality: String?
    let country: String?
    
    enum CodingKeys: String, CodingKey {
        case street, postalCode, locality, country
    }
    
    var fullAddress: String {
        return "\(street ?? ""), \(locality ?? "")"
    }
}
