//
//  ApiManager.swift
//  WBooks
//
//  Created by leonardo.a.simoza on 7/11/21.
//

import Foundation

import Moya

protocol ApiProtocol {
    associatedtype T: TargetType
    var provider: MoyaProvider<T> { get }
    var endpoint: String { get }
    var apiVersion: String { get }
}

class ApiManager: ApiProtocol {
    
    typealias T = ApiService
    let logger = NetworkLoggerPlugin(configuration: NetworkLoggerPlugin.Configuration(logOptions: [.formatRequestAscURL, .errorResponseBody]))

    let provider = MoyaProvider<ApiService>(plugins: [NetworkLoggerPlugin(configuration: NetworkLoggerPlugin.Configuration(logOptions: [.formatRequestAscURL, .errorResponseBody]))])
    let endpoint: String
    let apiVersion: String
    
    init(configuration: ApiConfig = .default) {
        self.endpoint = configuration.endpoint
        self.apiVersion = configuration.apiVersion
    }
}
