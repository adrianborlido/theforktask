//
//  String+Extension.swift
//  TheForkTask
//
//  Created by Adrian Borlido on 9/5/22.
//

import Foundation

extension String {
    var localized: String {
         return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
    
    func localized(with arguments: [CVarArg]) -> String {
        return String(format: self.localized, locale: nil, arguments: arguments)
    }
}
