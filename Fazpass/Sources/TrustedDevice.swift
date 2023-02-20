//
//  FazpassTd.swift
//  ios-trusted-device
//
//  Created by Binar - Mei on 11/01/23.
//

import Foundation

public class TrustedDevice {
    private var usecase: UsecaseProtocol
    
    init() {
        self.usecase = Usecases.init()
    }
    
    public func enrollDeviceByPin(_ email: String?,_ phone: String?, pin: String?, results: @escaping (Result<Void, FazPassError>) -> Void) {
        if ((email?.isEmpty == nil)) && ((phone?.isEmpty) == nil) {
            results(.failure(.phoneOrEmailEmpty))
            return
        }
        usecase.postCheck(phoneNumber: phone ?? "", email: email ?? "") { checkResults in
            switch checkResults {
            case .success(let response):
                let status = Status.setStatus(status: response?.apps?.current?.isTrusted)
                if status == .trusted {
                    self.usecase.postValidatePin(pin: pin ?? "") { validateResults in
                        switch validateResults {
                        case .success:
                            results(.success(()))
                        case .failure(let error):
                            results(.failure(error))
                        }
                    }
                } else {
                    let error = ErrorResponse.init(code: "409", status: false, message: "device untrusted")
                    results(.failure(.softError(error: error)))
                }
            case .failure(let error):
                results(.failure(error))
            }
        }
    }
}
