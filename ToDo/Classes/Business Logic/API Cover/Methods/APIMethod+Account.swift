//
//  APIMethod+Account.swift
//  ToDo
//
//  Created by Илья Халяпин on 09.01.2018.
//  Copyright © 2018 Илья Халяпин. All rights reserved.
//

import Alamofire

extension API.Method.Account {
    
    /// Создание учетной записи пользователя
    @discardableResult
    static func registration(requestData data: API.Model.Account.RegistrationRequestModel, completionHandler completion: @escaping (_ data: API.Method.VoidResponse) -> Void) -> Request {
        return API.Method.requestBuilder(resource: .accountRegistration, requestData: data, completionHandler: completion)
    }
    
    /// Авторизация пользователя в приложении
    @discardableResult
    static func login(requestData data: API.Model.Account.LoginRequestModel, completionHandler completion: @escaping (_ data: () throws -> API.Model.Account.LoginResponseModel) -> Void) -> Request {
        return API.Method.requestBuilder(resource: .accountLogin, requestData: data, completionHandler: completion)
    }
    
    /// Выход из приложения
    @discardableResult
    static func logout(appId: String, token: String, completionHandler completion: @escaping (_ data: API.Method.VoidResponse) -> Void) -> Request {
        return API.Method.requestBuilder(resource: .accountLogout, appId: appId, token: token, completionHandler: completion)
    }
    
}
