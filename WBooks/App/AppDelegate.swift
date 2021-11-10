//
//  AppDelegate.swift
//  WBooks
//
//  Created by leonardo.a.simoza on 22/10/21.
//

import UIKit
import CocoaLumberjack

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupLogs()
        return true
    }

    // MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    // MARK: Setup Logs
    fileprivate func setupLogs() {
        let formatter = LogsManager()
        DDOSLogger.sharedInstance.logFormatter = formatter
        DDLog.add(DDOSLogger.sharedInstance) // Uses os_log
        dynamicLogLevel = DDLogLevel.verbose
        let version = "versionLog".localized().replacingOccurrences(of: "{version}",
                                                                    with: Constants.AppInfo.appVersion)
        let buildVersion = "buildVersionLog".localized().replacingOccurrences(of: "{build}",
                                                                              with: Constants.AppInfo.buildVersion)
        let iOSVersion = "iosVersionLog".localized().replacingOccurrences(of: "{ios_version}",
                                                                          with: Constants.AppInfo.iosVersion)
        let bundleIdentifier = "bundleIdentifierLog".localized().replacingOccurrences(of: "{bundle_identifier}",
                                                                                      with: Constants.AppInfo.bundleIdentifier)
        DDLogInfo("""
            \n---------------------------------------------------------------------
            - \(version)
            - \(buildVersion)
            - \(iOSVersion)
            - \(bundleIdentifier)
            ---------------------------------------------------------------------\n
            """)
        DDLogInfo("Configured CocoaLumberjack")
    }
}
