//
//  RuntimeInfo.swift
//  
//
//  Created by hexagram on 2023/7/6.
//

import Foundation

public struct RuntimeInfo {
  private static let receiptPath = Bundle.main.appStoreReceiptURL?.path ?? ""
  public static let isTestFlight = receiptPath.contains("sandboxReceipt")
  public static let isSimulator = receiptPath.contains("CoreSimulator")
  public static let version = Bundle.main.infoDictionary!["CFBundleShortVersionString"]! as! String
  public static let buildNumber = Bundle.main.infoDictionary!["CFBundleVersion"] as! String
  public static var fullVersion = "\(version)(\(buildNumber))"
  public static var isChinaJurisdiction =
    Locale.current.regionCode?.lowercased() == "cn"
    || (
      Locale.current.languageCode?.lowercased() == "zh"
      && Locale.current.scriptCode?.lowercased() == "hans"
    )
}
