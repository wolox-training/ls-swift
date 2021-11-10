//
//  ApiConfig.swift
//  WBooks
//
//  Created by leonardo.a.simoza on 7/11/21.
//

import Foundation

struct ApiConfig {
    let endpoint: String
    let apiVersion: String
    static let manager = ApiManager()
    static let `default` = ApiConfig(endpoint: Environment.baseUrl.absoluteString, apiVersion: "v1")
}
