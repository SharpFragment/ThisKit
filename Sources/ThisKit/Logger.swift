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
                  level: OSLogType = .default,
                  file: String = #file,
                  line: Int = #line,
                  column: Int = #column,
                  function: String = #function) {
    logger.log(level: level, "\(file) \(function) \(line) \(column) \(log)")
  }

  public func debug(_ message: String,
                    file: String = #file,
                    line: Int = #line,
                    column: Int = #column,
                    function: String = #function) {
    log(message, level: .debug, file: file, line: line, column: column, function: function)
  }
  
  public func info(_ message: String,
                    file: String = #file,
                    line: Int = #line,
                    column: Int = #column,
                    function: String = #function) {
    log(message, level: .info, file: file, line: line, column: column, function: function)
  }
  
  public func error(_ message: String,
                    file: String = #file,
                    line: Int = #line,
                    column: Int = #column,
                    function: String = #function) {
    log(message, level: .error, file: file, line: line, column: column, function: function)
  }
  
  public func fault(_ message: String,
                    file: String = #file,
                    line: Int = #line,
                    column: Int = #column,
                    function: String = #function) {
    log(message, level: .fault, file: file, line: line, column: column, function: function)
  }
}
