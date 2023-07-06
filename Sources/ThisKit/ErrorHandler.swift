//
//  ErrorHandler.swift
//
//
//  Created by hexagram on 2023/7/6.
//

import Foundation
import SwiftUI

public final class TKErrorHandler: ObservableObject {
  public static let `default` = TKErrorHandler()
  
  @Published var error: NSError?
  @Published var didError = false
  
  public enum AnyError:Error {
    case any(String)
  }
  
  public func handle(err: NSError) {
    TKLog(err.debugDescription)
    self.error = err
    self.didError = true
  }
  
  public func handle(string: String) {
    TKLog(string)
    self.error = AnyError.any(string) as NSError
    self.didError = true
  }
  
  public func handle(_ block: (() throws -> Void)) {
    do {
      try block()
    } catch let err as NSError {
      TKLog(err.debugDescription)
      self.error = err
      self.didError = true
    } catch let any {
      let err = AnyError.any(any.localizedDescription)
      self.error = err as NSError
      self.didError = true
      TKLog(any.localizedDescription)
    }
  }
  
  public func handle(_ block: (() async throws -> Void)) async {
    do {
      try await block()
    } catch let err as NSError {
      TKLog(err.debugDescription)
      self.error = err
      self.didError = true
    } catch let any {
      let err = AnyError.any(any.localizedDescription)
      self.error = err as NSError
      self.didError = true
      TKLog(any.localizedDescription)
    }
  }
  
  public init(error: NSError? = nil) {
    self.error = error
  }
  
  public struct TKErrorHandlerModifier:ViewModifier {
    @EnvironmentObject private var errorHandler: TKErrorHandler

    public init() {}
    
    public func body(content: Content) -> some View {
      content
        .alert(
          "Error!",
          isPresented: $errorHandler.didError,
          presenting: errorHandler.error) { err in
            Button(role: .cancel) {
              
            } label: {
              Text("OK")
            }
          } message: { err in
            switch err as Error {
            case TKErrorHandler.AnyError.any(let str):
              Text(str)
            default:
              Text(err.localizedDescription)
            }
          }
    }
  }
}
