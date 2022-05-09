//
//  UserDefaultsManager.swift
//  TheForkTask
//
//  Created by Adrian Borlido on 7/5/22.
//

import Foundation
import UIKit

public protocol UserDefaultsManagerInterface {
    func set<T:Codable>(object: T, forKey key: String) throws
    func getObject<T: Codable>(forKey key: String, ofType type: T.Type) throws -> T
    func deleteObject(forKey key: String)
}

public class UserDefaultsManager: UserDefaultsManagerInterface {
    static let shared = UserDefaultsManager()
    
    private lazy var jsonEncoder = {
        JSONEncoder()
    }()
    
    private lazy var jsonDecoder = {
        return JSONDecoder()
    }()
    
    private init() { }
    
    public func set<T:Codable>(object: T, forKey key: String) throws {
        do {
            let objectToStore = try jsonEncoder.encode(object)
            UserDefaults.standard.setValue(objectToStore, forKey: key)
        } catch {
            throw DefaultsError.failedToEncode
        }
    }
    
    public func getObject<T: Codable>(forKey key: String, ofType type: T.Type) throws -> T {
        let storedData = UserDefaults.standard.object(forKey: key) as? Data
        guard let data = storedData else { throw DefaultsError.noData }
        do {
            return try jsonDecoder.decode(type, from: data)
        } catch {
            throw DefaultsError.failedToDecode
        }
    }
    
    public func deleteObject(forKey key: String) {
        UserDefaults.standard.removeObject(forKey: key)
    }
    
    enum DefaultsError: Error {
        case failedToEncode
        case failedToDecode
        case noData
    }
}
