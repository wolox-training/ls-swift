//
//  Environment.swift
//  WBooks
//
//  Created by leonardo.a.simoza on 6/11/21.
//

import Foundation

public enum Environment {
    
    // MARK: - Keys
    enum Keys {
            static let parameters = "Parameters"
            static let baseURL = "API_BASE_URL"
    }
    
    // MARK: - Plist
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("Plist file not found")
        }
        return dict
    }()
    
    // MARK: - Plist Values
    static let baseUrl: URL = {
        guard let parameters = Environment.infoDictionary[Keys.parameters] as? [String: String],
              let baseURLstring = parameters[Keys.baseURL] else {
            fatalError("Base URL not set in plist for this environment")
        }
        guard let url = URL(string: baseURLstring) else {
            fatalError("Base URL is invalid")
        }
        return url
    }()
}
