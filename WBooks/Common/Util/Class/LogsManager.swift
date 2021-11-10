//
//  LogsManager.swift
//  WBooks
//
//  Created by leonardo.a.simoza on 5/11/21.
//

import CocoaLumberjack

class LogsManager: NSObject, DDLogFormatter {
    
    // MARK: Custom methods
    func format(message logMessage: DDLogMessage) -> String? {
        var logLevel: String
        var formattedLog = ""
        let logFlag: DDLogFlag = logMessage.flag
        let method: String = "\(logMessage.fileName).\(String(describing: logMessage.function!))"
        
        switch logFlag {
        case .error : logLevel = "ERROR"
        case .warning : logLevel = "WARNING"
        case .info : logLevel = "INFO"
        case .debug : logLevel = "DEBUG"
        default : logLevel = "VERBOSE"
        }
        
        formattedLog = "[\(logLevel)] [\(method):\(logMessage.line)] [\(logMessage.message)]"
        return formattedLog
    }
}
