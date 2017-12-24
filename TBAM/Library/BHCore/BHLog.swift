//
//  BHLog.swift
//  Blue Heron Labs Core Library for Swift
//
//  http://blueheronlabs.net/
//
//
//  The software in this Core library is licensed under the MIT License,
//  and was created by Blue Heron Labs LLC, except where otherwise noted.
//
//  Copyright (c) 2014 Blue Heron Labs LLC. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software library and documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import Foundation

///
/// Log Level facility, used for setting log levels and providing icons
///
public enum BHLogLevel : Int
{
    case off
    case verbose
    case trace
    case debug
    case quick
    case info
    case event
    case warning
    case error
    case fatal
    
    ///
    /// Returns the emoji icon associated with this log level
    ///
    func icon() -> String
    {
        switch self {
            case .off     : return ""
            case .verbose : return "⚪️"  // alternate 💬
            case .trace   : return "⚫️"
            case .debug   : return "✅"
            case .quick   : return "☢️"
            case .info    : return "ℹ️"
            case .event   : return "🔵"
            case .warning : return "⚠️"
            case .error   : return "🔴"  // alternate ⛔️
            case .fatal   : return "👿"
        }
    }
    
    /// Returns true if the given log level can be displayed
    func allows(_ level :BHLogLevel) -> Bool
    {
        return (self != .off && level != .off && self.rawValue <= level.rawValue)
    }
}

// MARK: - Console Logging

///
/// Console Logging when running in DEBUG mode.
///
/// To turn on logging: set '-D DEBUG' in 'Build Settings' > 'Other Swift Flags'
///
public struct BHLog
{
    fileprivate static var logLevel = BHLogLevel.debug

    // MARK: Convenience Functions

    ///
    /// Set the minimum log level. Messages below the given log level will be suppressed.
    ///
    public static func setLevel(_ level :BHLogLevel)
    {
        #if DEBUG
            BHLog.logLevel = level
        #endif
    }
    
    ///
    /// Verbose messages, usually considered "noise"
    ///
    public static func verbose(_ message :() -> String)
    {
        #if DEBUG
            BHLog.console(.verbose, message: message)
        #endif
    }
    
    ///
    /// Trace messages, usually for function calls
    ///
    public static func trace(_ message :() -> String)
    {
        #if DEBUG
            BHLog.console(.trace, message: message)
        #endif
    }
    
    ///
    /// Show a debug message
    ///
    public static func debug(_ message :() -> String)
    {
        #if DEBUG
            BHLog.console(.debug, message: message)
        #endif
    }
    
    ///
    /// Another debug message, used for short-term "printf debugging"
    /// and meant to have an icon that is easy to see
    ///
    public static func quick(_ message :() -> String)
    {
        #if DEBUG
            BHLog.console(.quick, message: message)
        #endif
    }
    
    ///
    /// Show an informational message
    ///
    public static func info(_ message :() -> String)
    {
        #if DEBUG
            BHLog.console(.info, message: message)
        #endif
    }
    
    ///
    /// Used to indicate a UI event
    ///
    public static func event(_ message :() -> String)
    {
        #if DEBUG
            BHLog.console(.event, message: message)
        #endif
    }
    
    ///
    /// Used to indicate a potential problem or inconsistency
    ///
    public static func warning(_ message :() -> String)
    {
        #if DEBUG
            BHLog.console(.warning, message: message)
        #endif
    }
    
    ///
    /// Error condition (non-fatal)
    ///
    public static func error(_ message :() -> String)
    {
        #if DEBUG
            BHLog.console(.error, message: message)
        #endif
    }
    
    ///
    /// Fatal error, potential show-stopper
    ///
    public static func fatal(_ message :() -> String)
    {
        #if DEBUG
            BHLog.console(.fatal, message: message)
        #endif
    }
    
    // MARK: URL Functions

    ///
    /// Show a URL
    ///
    public static func url(_ label :String, method: String, url :String, params :[String:Any]?)
    {
        #if DEBUG
            BHLog.url(label, method: method, url: url, params: params, reply: "")
        #endif
    }
    
    ///
    /// Show a URL. Use the reply variable to show connection statistics.
    ///
    public static func url(_ label :String, method: String, url :String, params :[String:Any]?, reply: String)
    {
        #if DEBUG
            var qs = ""
            if let params = params {
                let num = params.count
                if (num > 0) {
                    qs = "?"
                    var counter = 0
                    for (key, value) in params {
                        if (counter > 0) {
                            qs += "&"
                        }
                        if ("password" == key.lowercased()) {
                            qs += "\(key)=xxxxxxxx"
                        } else {
                            qs += "\(key)=\(value)"
                        }
                        counter += 1
                    }
                }
            }
            
            let icon      = ("" == reply) ? "➡️" : "⬅️"
            let direction = ("" == reply) ? "-->" : "<--"
            var message   = label
            if ("" != message) {
                message += " "
            }
            message += "\(method) \(direction) \(url)\(qs) \(reply)"
            
            BHLog.console(.info, bullet: icon) { message }
        #endif
    }
    
    // MARK: Low-Level Functions
    
    ///
    /// Show a message, using the default log level icon
    ///
    public static func console(_ level :BHLogLevel, message :() -> String)
    {
        #if DEBUG
            BHLog.console(level, bullet: level.icon(), message: message)
        #endif
    }
    
    ///
    /// Show a message, using the given bullet icon
    ///
    public static func console(_ level :BHLogLevel, bullet :String, message :() -> String)
    {
        #if DEBUG
            if (BHLog.logLevel.allows(level)) {
                print("\(bullet) \(message())")
            }
        #endif
    }
    
    ///
    /// Format a timestamp
    ///
    fileprivate static func timestamp2string(_ dateObj :Date) -> String
    {
        return String(format: "%.06f", dateObj.timeIntervalSince1970)
    }
}


// MARK: - Memory Logging

public extension BHLog
{
#if DEBUG
    private static var memoryLog :[String:String] = [:]
    
    private static func memory(message :() -> String)
    {
        let now = Date()
        let key = BHLog.timestamp2string(now)
        BHLog.memoryLog[key] = message()
    }
    
    public static func readMemoryLog(fromTheLastXSeconds :Int) -> String
    {
        let now    = Date()
        let prev   = now.addingTimeInterval(TimeInterval(-1 * fromTheLastXSeconds))  // negative seconds
        let cutoff = BHLog.timestamp2string(prev)
        var output = ""
        let arr = BHLog.memoryLog.filter { $0.0 >= cutoff }
            .sorted { $0.0 < $1.0 }  // sort by dictionary key
        for (key, message) in arr {
            let text = "\(key) \(message)\n"
            output += text
        }
        return output
    }
#else
    // stubs
    public static func memory(_ message :() -> String) { }
    public static func readMemoryLog() -> String     { return "" }
#endif
}


// MARK: - File Logging

public extension BHLog
{
#if DEBUG
    private static var fileLogging = false
    
    public static let LOGFILE = "debug.log"
    
    public static func enableFileLogging()
    {
        BHLog.fileLogging = true
    }
    
    public static func file(message :() -> String)
    {
        BHLog.fileAppend(message: message())
    }
    
    public static func fileSeparator()
    {
        BHLog.fileAppend(message: "============================")
    }
    
    private static func fileAppend(message :String)
    {
        if (!BHLog.fileLogging) {
            return
        }
        
        if let path = BHLog.getLogFilePath() {
            if let outputStream = OutputStream(toFileAtPath: path, append: true) {
                let now = Date()
                let key = BHLog.timestamp2string(now)
                let text = "\(key) \(message)\n"
                outputStream.open()
                outputStream.write(text, maxLength: text.count)
                outputStream.close()
            }
        }
    }
    
    public static func readLogFile() -> String
    {
        if let path = BHLog.getLogFilePath() {
            do {
                return try String(contentsOfFile: path)
            } catch {
            }
        }
        
        return ""
    }
    
    public static func deleteLogFile()
    {
        if let path = BHLog.getLogFilePath() {
            do {
                try FileManager.default.removeItem(atPath: path)
            } catch {
            }
        }
        
        return
    }
    
    private static func getLogFilePath() -> String?
    {
        let dirs = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)
        if (dirs.count > 0) {
            let dir = dirs[0]
            return (dir as NSString).appendingPathComponent(BHLog.LOGFILE)
        }
        
        return nil
    }
#else
    // stubs
    public static func enableFileLogging()           { }
    public static func file(_ message :() -> String) { }
    public static func fileSeparator()               { }
    public static func readLogFile()                 -> String { return "" }
    public static func deleteLogFile()               { }
#endif
}
