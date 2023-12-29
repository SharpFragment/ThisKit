//
//  Logger.swift
//
//
//  Created by hexagram on 2023/7/6.
//

import Foundation
import OSLog

public func TKLog(_ message: String,
                  file: String = #file,
                  line: Int = #line,
                  column: Int = #column,
                  function: String = #function) {
  TKLogger.default.log(message, file: file, line: line, column: column, function: function)
}

public func TKLog(_ message: String,
                  file: String = #file,
                  line: Int = #line,
                  column: Int = #column,
                  function: String = #function) -> String {
  TKLogger.default.log(message, file: file, line: line, column: column, function: function)
  return "\(function): \(message)"
}

// TODO: export use OSLogStore
public class TKLogger {
  public static let `default` = TKLogger()

  private var logger: Logger

  public init(subsystem: String = Bundle.main.bundleIdentifier ?? "thiskit.hexagr.am", category: String = "default") {
    logger = Logger(subsystem: subsystem, category: category)
  }

//  public init(subsystem: String = Bundle.main.bundleIdentifier ?? "thiskit.hexagr.am", category: OSLog.Category = .pointsOfInterest) {
//    logger = Logger(subsystem: subsystem, category: category)
//  }

  public func log(_ log: String,
                  privacy: OSLogPrivacy = .public,
                  level: OSLogType = .default,
                  file: String = #file,
                  line: Int = #line,
                  column: Int = #column,
                  function: String = #function) {
    // TODO
    logger.log(level: level, "\(file) \(function) \(line) \(column) \(log, privacy: .public)")
  }

  public func debug(_ message: String,
                    privacy: OSLogPrivacy = .public,
                    file: String = #file,
                    line: Int = #line,
                    column: Int = #column,
                    function: String = #function) {
    log(message, privacy: privacy, level: .debug, file: file, line: line, column: column, function: function)
  }
  
  public func info(_ message: String,
                    privacy: OSLogPrivacy = .public,
                    file: String = #file,
                    line: Int = #line,
                    column: Int = #column,
                    function: String = #function) {
    log(message, privacy: privacy, level: .info, file: file, line: line, column: column, function: function)
  }
  
  public func error(_ message: String,
                    privacy: OSLogPrivacy = .public,
                    file: String = #file,
                    line: Int = #line,
                    column: Int = #column,
                    function: String = #function) {
    log(message, privacy: privacy, level: .error, file: file, line: line, column: column, function: function)
  }
  
  public func fault(_ message: String,
                    privacy: OSLogPrivacy = .public,
                    file: String = #file,
                    line: Int = #line,
                    column: Int = #column,
                    function: String = #function) {
    log(message, privacy: privacy, level: .fault, file: file, line: line, column: column, function: function)
  }
}
