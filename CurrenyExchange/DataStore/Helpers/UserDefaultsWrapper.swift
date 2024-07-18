//
//  UserDefaultsWrapper.swift
//  CurrenyExchange
//
//  Created by Janbaz Ali on 04/11/2023.
//

import Foundation

import Networking

protocol UserDefaultsWrapping {
    func save<T: Codable>(_ object: T, forKey key: String)
    func load<T: Codable>(forKey key: String) -> T?
    func saveDate(date: Date, forKey key: String)
    func loadDate(forKey key: String) -> Date?
}

class UserDefaultsWrapper: UserDefaultsWrapping {

    private let userDefaults: UserDefaults

    // MARK: -  Init
    init() {
        userDefaults = UserDefaults.standard
    }

    // MARK: - Date
    func saveDate(date: Date, forKey key: String) {
        userDefaults.set(date, forKey: key)
    }

    func loadDate(forKey key: String) -> Date? {
        userDefaults.value(forKey: key) as? Date
    }

    // MARK: - Codable
    func save<T: Codable>(_ object: T, forKey key: String) {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(object)
            userDefaults.set(data, forKey: key)

        } catch {
            print("Failed to save object to UserDefaults: \(error)")
        }
    }

    func load<T: Codable>(forKey key: String) -> T? {
        if let data = userDefaults.data(forKey: key) {
            do {
                let decoder = JSONDecoder()
                let object = try decoder.decode(T.self, from: data)
                return object
            } catch {
                print("Failed to load object from UserDefaults: \(error)")
            }
        }
        return nil
    }
}
