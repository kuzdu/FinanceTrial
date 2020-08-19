//
//  BookingPersistence.swift
//  FinanceTrial
//
//  Created by Michael Rothkegel on 19.08.20.
//  Copyright © 2020 Michael Rothkegel. All rights reserved.
//

import Foundation

enum InternalError: Error {
    case parsingError(String)
}

class BookingPersistence {
    // MARK: - privates
    private enum PersistenceKeys: String {
        case user = "userKey"
    }
    
    private func readJson<T: Codable>(dataString: String, object: T) throws -> T {
        do {
            guard let jsonData = dataString.data(using: .utf8) else {
                throw InternalError.parsingError("Cannot convert dataString \(dataString.prefix(20)) to utf8 data")
            }
            let parsedJson = try JSONDecoder().decode(T.self, from: jsonData)
            return parsedJson
        } catch {
            throw InternalError.parsingError("Cannot parse dataString \(dataString.prefix(20)) to object \(T.self) message")
        }
    }
    
    private func toJson<T: Codable>(type: T) throws -> String {
        do {
            let typeData = try JSONEncoder().encode(type.self)
            return String(decoding: typeData, as: UTF8.self)
        } catch {
            throw InternalError.parsingError("Cannot parse object \(type.self) to json")
        }
    }
    
    // MARK: - publics
    func loadUser() throws -> User  {
        guard let userString = UserDefaults.standard.string(forKey: PersistenceKeys.user.rawValue) else {
            // fallback for first init
            return User(name: "Michael", bookings: [])
        }
        
        do {
            let user = try readJson(dataString: userString, object: User())
            return user
        } catch {
            throw error
        }
    }
    
    func saveUser(_ user: User) throws {
        do {
            let userString = try toJson(type: user)
            UserDefaults.standard.set(userString, forKey: PersistenceKeys.user.rawValue)
        } catch {
            throw error
        }
    }
    
    func addBooking(_ booking: Booking) throws {
        do {
            var user = try loadUser()
            user.bookings.append(booking)
            try saveUser(user)
        } catch {
            throw error
        }
    }
}
