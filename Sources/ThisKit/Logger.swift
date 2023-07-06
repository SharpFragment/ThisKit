//
//  Logger.swift
//
//
//  Created by hexagram on 2023/7/6.
//

import Foundation

func TKLog(_ log: Any,
           file: String = #file,
           line: Int = #line,
           column: Int = #column,
           function: String = #function) {
  TKLogger.default.log(
    log,
    file: file,
    line: line,
    column: column,
    function: function
  )
}

class TKLogger {
  static let `default` = TKLogger()
  
//  static let LogsDir = WBInternalURL.documents.appendingPathComponent("Logs",isDirectory: true)
  var logsDir: URL?
  
  var todayLogsDir: URL? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yy-MM-dd"
    let res = dateFormatter.string(from: Date.now)
    
    return self.logsDir?.appendingPathComponent(res, isDirectory: true)
  }
  
  var fileHandler:FileHandle? = nil
  
  var logUrl:URL? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "HH-mm"
    let res = dateFormatter.string(from: Date.now)
    return self.todayLogsDir?
      .appendingPathComponent(res,isDirectory: false)
      .appendingPathExtension("txt")
      .appendingPathExtension(for: .text)
  }
  
  init(logsDir: URL? = nil) {
    do {
      self.logsDir = logsDir
      guard let logsDir = self.logsDir,
            let todayLogsDir = self.todayLogsDir,
            let logUrl = self.logUrl
      else { return }
      
      try FileManager.default.findOrCreateDir(at: logsDir)
      try FileManager.default.findOrCreateDir(at: todayLogsDir)
      FileManager.default.findOrCreateFile(at: logUrl)
      fileHandler = try FileHandle(forWritingTo: logUrl)
      cleanOldLogs()
    } catch {
      NSLog("Init TKLogger Error: \(error)")
    }
  }
  
  deinit {
    if let fileHandler = fileHandler {
      try? fileHandler.close()
    }
  }
  
  func cleanOldLogs() {
    do {
      guard let logsDir = self.logsDir else { return }
      let urls = try FileManager.default.contentsOfDirectory(at: logsDir, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
      
      var res = try urls.sorted {
        let date1 = try FileManager.default.attributesOfItem(atPath: $0.path)[.creationDate] as? NSDate
        let date2 = try FileManager.default.attributesOfItem(atPath: $1.path)[.creationDate] as? NSDate
        guard let date1 = date1 as Date?, let date2 = date2 as Date? else {
          return true
        }
        return date1 < date2
      }
      res.removeFirst(res.count > 5 ? 5 : res.count)
      try res.forEach { url in
        try FileManager.default.removeIfExists(at: url)
      }
    } catch {
      NSLog("TKLogger cleanOldLogs Error: \(error)")
    }
  }
  
  func log(_ log: Any,
             file: String = #file,
             line: Int = #line,
             column: Int = #column,
             function: String = #function) {
    let LogString = "file: \(file) line: \(line) column: \(column) function: \(function) log: \(log)"
    
    #if DEBUG
      NSLog(LogString)
      logToFile(log: LogString)
    #else
      if TKRuntimeInfo.isSimulator || TKRuntimeInfo.isTestFlight {
        NSLog(LogString)
      }
      logToFile(log: LogString)
    #endif
  }
  
  func logToFile(log:String) {
    do {
      guard let fileHandler = fileHandler else {
        return
      }
      try fileHandler.seekToEnd()
      let data = (
        Date.now.formatted() + ": " + log + "\n"
      ).data(using: .utf8)!
      try fileHandler.write(contentsOf: data)
    } catch {
      NSLog("TKLog logToFile Error: \(error)")
    }
  }
}

