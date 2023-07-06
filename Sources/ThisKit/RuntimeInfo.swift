//
//  RuntimeInfo.swift
//  
//
//  Created by hexagram on 2023/7/6.
//

import Foundation

struct TKRuntimeInfo {
  private static let receiptPath = Bundle.main.appStoreReceiptURL?.path ?? ""
  static let isTestFlight = receiptPath.contains("sandboxReceipt")
  static let isSimulator = receiptPath.contains("CoreSimulator")
  static let version = Bundle.main.infoDictionary!["CFBundleShortVersionString"]! as! String
  static let buildNumber = Bundle.main.infoDictionary!["CFBundleVersion"] as! String
  static var fullVersion = "\(version)(\(buildNumber))"
  static var isChinaJurisdiction =
    Locale.current.regionCode?.lowercased() == "cn"
    || (
      Locale.current.languageCode?.lowercased() == "zh"
      && Locale.current.scriptCode?.lowercased() == "hans"
    )
}
