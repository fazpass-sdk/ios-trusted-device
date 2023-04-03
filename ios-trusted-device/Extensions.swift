//
//  Extensions.swift
//  ios-trusted-device
//
//  Created by Andri nova riswanto on 27/03/23.
//

import Foundation

extension Result where Success == Void {
    public static var success: Result { .success(()) }
}

public enum Results<Success, Incoming, Failure> {
    case success(Success)
    case incomingMessage(Incoming)
    case failure(Failure)
}

public protocol TdResult{
    func onSuccess(td:TD_STATUS, cd:CD_STATUS)->Void
    func onFailure()->Void
}
