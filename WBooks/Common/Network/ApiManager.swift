//
//  ApiManager.swift
//  WBooks
//
//  Created by leonardo.a.simoza on 7/11/21.
//

import Moya

protocol ApiProtocol {
    associatedtype ApiServices: TargetType
    var provider: MoyaProvider<ApiServices> { get }
    var endpoint: String { get }
    var apiVersion: String { get }
}

class ApiManager: ApiProtocol {
    
    // MARK: - Properties
    typealias ApiServices = ApiService
    let provider = MoyaProvider<ApiServices>(
        plugins: [NetworkLoggerPlugin(
            configuration: NetworkLoggerPlugin.Configuration(
                logOptions: [.formatRequestAscURL, .errorResponseBody]))])
    let endpoint: String
    let apiVersion: String
    
    init(configuration: ApiConfig = .default) {
        self.endpoint = configuration.endpoint
        self.apiVersion = configuration.apiVersion
    }
}
