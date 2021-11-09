//
//  GlobalConstants.swift
//  WBooks
//
//  Created by leonardo.a.simoza on 2/11/21.
//

import UIKit
import RxSwift

let disposeBag = DisposeBag()

struct Constants {
    struct DeviceBase {
        static let width: CGFloat = 375
        static let height: CGFloat = 667
    }
    
    struct AppInfo {
        private static let infoDictionary: [String: Any] = {
            guard let dict = Bundle.main.infoDictionary else {
                fatalError("Plist file not found")
            }
            return dict
        }()
        static let bundleIdentifier = infoDictionary["CFBundleIdentifier"] as? String ?? "Unknown"
        static let appVersion = infoDictionary["CFBundleShortVersionString"] as? String ?? "Unknown"
        static let buildVersion: String = (infoDictionary["CFBundleVersion"] as AnyObject?) as? String ?? "Unknown"
        static let iosVersion = UIDevice.current.systemVersion
    }
    
    struct PathWS {
        static let books: String = "/books"
        static func bookCommentsById(id: Int) -> String { return books+"/\(id)/comments" }
    }
}
