//
//  MainPhoto.swift
//  TheForkTask
//
//  Created by Adrian Borlido on 7/5/22.
//

import Foundation

struct MainPhoto: Codable {
    let source: String?
    let small: String?
    let medium: String?
    let large: String?
    
    enum CodingKeys: String, CodingKey {
        case source
        case small = "240x135"
        case medium = "664x374"
        case large = "1350x759"
    }
}
