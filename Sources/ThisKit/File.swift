//
//  File.swift
//  
//
//  Created by Hexagram on 2023/12/30.
//

import Foundation

public enum UnknownError: Error {
  case string(String)
  case error(Error)
  case any(Any)
}
