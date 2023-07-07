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
  
  @MainActor @Published var error: NSError?
  @MainActor @Published var didError = false
  
  public enum AnyError:Error {
    case any(String)
  }
  
  public func handle(err: NSError) {
    Task {
      await MainActor.run {
        TKLog(err.debugDescription)
        self.error = err
        self.didError = true
      }
    }
  }
  
  public func handle(string: String) {
    self.handle(err: AnyError.any(string) as NSError)
  }
  
  public func handle(_ block: (() throws -> Void)) {
    do {
      try block()
    } catch let err as NSError {
      self.handle(err: err)
    } catch let any {
      let err = AnyError.any(any.localizedDescription) as NSError
      self.handle(err: err)
    }
  }
  
  public func handle(_ block: (() async throws -> Void)) async {
    do {
      try await block()
    } catch let err as NSError {
      self.handle(err: err)
    } catch let any {
      let err = AnyError.any(any.localizedDescription) as NSError
      self.handle(err: err)
    }
  }
  
  public init() {}
  
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
              Text(err.debugDescription)
            }
          }
    }
  }
}
