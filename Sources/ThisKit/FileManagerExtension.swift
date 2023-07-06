//
//  FileManagerExtension.swift
//
//
//  Created by hexagram on 2023/7/6.
//

import Foundation

public extension FileManager {
  func removeIfExists(at url: URL) throws {
    if FileManager.default.fileExists(atPath: url.path) {
      try FileManager.default.removeItem(at: url)
    }
  }
  
  func findOrCreateDir(at url: URL) throws {
    if !FileManager.default.fileExists(atPath: url.path, isDirectory: nil) {
      try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
    }
  }

  func findOrCreateFile(at url: URL) {
    if !FileManager.default.fileExists(atPath: url.path, isDirectory: nil) {
      FileManager.default.createFile(atPath: url.path, contents: "".data(using: .utf8), attributes: nil)
    }
  }
}
