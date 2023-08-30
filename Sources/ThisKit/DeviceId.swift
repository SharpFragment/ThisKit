//
//  DeviceId.swift
//  AppPrivacyInsights (iOS)
//
//  Created by hexagram on 2021/11/12.
//

import Foundation
#if canImport(UIKit)
import UIKit
#endif

public struct Device {
  public static let debugSimulatorIdentifier = UUID(uuidString: "00000000-19DD-0000-0000-CC7DB2958ABA")
  public static let debugGeneralIdentifier = UUID(uuidString: "11111111-19DD-0000-0000-CC7DB2958ABA")
  public static var macosIdStoreageKey = "macOSDeviceIdKey"
  
  public static func id() -> UUID? {
    #if DEBUG
    if RuntimeInfo.isSimulator {
      return Self.debugSimulatorIdentifier
    }
    return Self.debugGeneralIdentifier
    #elseif os(macOS)
    guard let str = UserDefaults.standard.string(forKey: Self.macosIdStoreageKey) else {
      let uuid = UUID()
      UserDefaults.standard.setValue(uuid, forKey: Self.macosIdStoreageKey)
      return uuid
    }
    return UUID(uuidString: str)
    #else
    UIDevice.current.identifierForVendor
    #endif
  }
}
