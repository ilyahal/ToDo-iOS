//
//  API+Method.swift
//  ToDo
//
//  Created by Илья Халяпин on 09.01.2018.
//  Copyright © 2018 Илья Халяпин. All rights reserved.
//

import Alamofire
import SwiftyJSON

extension API {
    
    /// Методы API
    final class Method {
        
        // MARK: - Подклассы
        
        /// Аутентификация
        final class Account { }
        
        /// Цвета
        final class Colors { }
        
        /// Иконки
        final class Icons { }
        
        /// Списки
        final class Lists { }
        
        /// Записи
        final class Items { }
        
        
        // MARK: - Типы данных
        
        /// Пустой ответ
        typealias VoidResponse = () throws -> Void
        
        
        // MARK: - Приватные свойства
        
        static let sessionManager: SessionManager = {
            let sessionConfiguration = URLSessionConfiguration.default
            sessionConfiguration.timeoutIntervalForRequest = 30
            
            return SessionManager(configuration: sessionConfiguration)
        }()
        
    }
    
}


// MARK: - Публичные методы

extension API.Method {
    
    /**
     Создать запрос
     - parameter resource: Ресурс, к которому происходит обращение
     - parameter requestData: Параметры запроса
     - parameter appId: Уникальный идентификатор экземпляра приложения
     - parameter appSecret: Токен
     - parameter completionHandler: Замыкание, выполняемое после завершения запроса
     */
    static func requestBuilder<ResponseType : API.ResponseModel>(resource: API.Resource, requestData data: API.RequestModel? = nil, appId: Int? = nil, token: String? = nil, completionHandler completion: @escaping (_ data: () throws -> ResponseType) -> Void) -> Request {
        let url = generateURL(for: resource, with: data)
        print("URL:\n\(url)")
        
        let parameters = data?.parameters
        let headers = generateHeaders(appId: appId, token: token)
        
        let completionHandler: (DataResponse<Any>) -> Void = { response in
            if let httpHeaders = response.request?.allHTTPHeaderFields {
                print("HTTP HEADERS:\n\(httpHeaders)")
            }
            if let httpBody = response.request?.httpBody {
                if let httpBody = NSString(data: httpBody, encoding: String.Encoding.utf8.rawValue) {
                    print("HTTP BODY:\n\(httpBody)")
                }
            }
            
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON:\n\(json)\n")
                
                if let statusCode = response.response?.statusCode {
                    switch statusCode {
                    case 200:
                        guard let responseData = ResponseType(json: json) else {
                            completion { throw API.Error.incorrectServerAnswer(methodTitle: resource.title) }
                            return
                        }
                        
                        completion { return responseData }
                        return
                        
                    default:
                        break
                    }
                }
                
                let error = API.Model.ErrorModel(json: json)
                completion { throw API.Error.unknown(error: error) }
            case .failure(let error):
                var message: String? = nil
                if let data = response.data {
                    let json = JSON(data)
                    if let error = API.Model.ErrorModel(json: json) {
                        message = error.message
                    }
                }
                
                print("Ошибка при запросе: \(error) \(message ?? .empty)")
                completion { throw API.ErrorHandling.generateError(from: error, resource: resource, message: message) }
            }
        }
        
        let request = generateRequest(url: url, parameters: parameters, headers: headers, completionHandler: completionHandler)
        return request
    }
    
    /**
     Создать запрос
     - parameter resource: Ресурс, к которому происходит обращение
     - parameter requestData: Параметры запроса
     - parameter appId: Уникальный идентификатор экземпляра приложения
     - parameter appSecret: Токен
     - parameter completionHandler: Замыкание, выполняемое после завершения запроса
     */
    static func requestBuilder(resource: API.Resource, requestData data: API.RequestModel? = nil, appId: Int? = nil, token: String? = nil, completionHandler completion: @escaping (_ data: VoidResponse) -> Void) -> Request {
        let url = generateURL(for: resource, with: data)
        print("URL:\n\(url)")
        
        let parameters = data?.parameters
        let headers = generateHeaders(appId: appId, token: token)
        
        let completionHandler: (DefaultDataResponse) -> Void = { response in
            if let httpHeaders = response.request?.allHTTPHeaderFields {
                print("HTTP HEADERS:\n\(httpHeaders)")
            }
            if let httpBody = response.request?.httpBody {
                if let httpBody = NSString(data: httpBody, encoding: String.Encoding.utf8.rawValue) {
                    print("HTTP BODY:\n\(httpBody)")
                }
            }
            
            if let error = response.error {
                var message: String? = nil
                if let data = response.data {
                    let json = JSON(data)
                    if let error = API.Model.ErrorModel(json: json) {
                        message = error.message
                    }
                }
                
                print("Ошибка при запросе: \(error) \(message ?? .empty)")
                completion { throw API.ErrorHandling.generateError(from: error, resource: resource, message: message) }
            } else {
                if let statusCode = response.response?.statusCode {
                    switch statusCode {
                    case 200:
                        completion { return }
                        return
                        
                    default:
                        break
                    }
                }
                
                print("Неизвестная ошибка при запросе")
                completion { throw API.Error.unknown(error: nil) }
            }
        }
        
        let request = generateRequest(url: url, parameters: parameters, headers: headers, completionHandler: completionHandler)
        return request
    }
    
}


// MARK: - Приватные методы

private extension API.Method {
    
    /**
     Сгенерировать URL
     - parameter resource: Ресурс, к которому происходит обращение
     - parameter requestData: Модель параметров запроса
     */
    static func generateURL(for resource: API.Resource, with requestData: API.RequestModel?) -> String {
        var url = API.baseURL + resource.rawValue
        if let path = requestData?.path {
            url += path
        }
        if let query = requestData?.query {
            url += query
        }
        
        return url
    }
    
    /// Получить заголовки запроса
    static func generateHeaders(contentType: String? = "application/json; charset=utf-8", accept: String? = "application/json", appId: Int?, token: String?) -> HTTPHeaders {
        var headers: [String : String] = [:]
        if let contentType = contentType {
            headers["Content-Type"] = contentType
        }
        if let accept = accept {
            headers["Accept"] = accept
        }
        if let locale = Locale.current.languageCode {
            headers["Accept-Language"] = locale
        }
        if let appId = appId {
            headers["X-Auth-AppId"] = "\(appId)"
        }
        if let token = token {
            headers["X-Auth-Token"] = token
        }
        
        return headers
    }
    
    /**
     Сгенерировать запрос
     - parameter url: URL
     - parameter parameters: Параметры, по умолчанию nil
     - parameter headers: HTTP заголовки
     - parameter completionHandler: Замыкание, выполняемое после завершения запроса
     */
    static func generateRequest(url: URLConvertible, parameters: Parameters? = nil, headers: HTTPHeaders, completionHandler: @escaping (DataResponse<Any>) -> Void) -> Request {
        let request = self.sessionManager.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).validate().responseJSON(queue: .global(qos: .userInitiated), completionHandler: completionHandler)
        return request
    }
    
    /**
     Сгенерировать запрос
     - parameter url: URL
     - parameter parameters: Параметры, по умолчанию nil
     - parameter headers: HTTP заголовки
     - parameter completionHandler: Замыкание, выполняемое после завершения запроса
     */
    static func generateRequest(url: URLConvertible, parameters: Parameters? = nil, headers: HTTPHeaders, completionHandler: @escaping (DefaultDataResponse) -> Void) -> Request {
        let request = self.sessionManager.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).validate().response(queue: .global(qos: .userInitiated), completionHandler: completionHandler)
        return request
    }
    
}
