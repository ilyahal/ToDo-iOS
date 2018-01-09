//
//  API+ErrorHandling.swift
//  ToDo
//
//  Created by Илья Халяпин on 09.01.2018.
//  Copyright © 2018 Илья Халяпин. All rights reserved.
//

import Alamofire

extension API {
    
    /// Вспомогательные методы для обработки ошибок при работе с API
    final class ErrorHandling {
        
        /// Обработать ошибку произошедшую при подключении к серверу
        static func generateError(from error: Swift.Error, resource: Resource, message: String?) -> Error {
            if let error = error as? AFError, error.isResponseValidationError, let code = error.responseCode {
                switch code {
                case 400:
                    return .badRequest(message: message)
                case 401:
                    return .unauthorized(message: message)
                case 403:
                    return .forbidden(message: message)
                case 404:
                    return .notFound(message: message)
                case 405:
                    return .methodNotAllowed(message: message)
                case 406:
                    return .notAcceptable(message: message)
                case 409:
                    return .conflict(message: message)
                case 410:
                    return .gone(message: message)
                case 415:
                    return .unsupportedMediaType(message: message)
                case 500:
                    return .internalServerError(message: message)
                case 503:
                    return .serviceUnavailable(message: message)
                    
                default:
                    break
                }
            } else {
                switch error._domain {
                case NSURLErrorDomain:
                    switch error._code {
                    case NSURLErrorCancelled:
                        return .cancelled
                    case NSURLErrorTimedOut:
                        return .timedOut(message: error.localizedDescription)
                    case NSURLErrorCannotConnectToHost:
                        return .cannotConnectToHost(message: error.localizedDescription)
                    case NSURLErrorNotConnectedToInternet:
                        return .notConnectedToInternet(message: error.localizedDescription)
                        
                    default:
                        break
                    }
                    
                default:
                    break
                }
            }
            
            return .otherErrorConnectionToServer(error: error)
        }
        
    }
    
}
