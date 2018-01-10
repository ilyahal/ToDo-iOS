//
//  APIMethod+Lists.swift
//  ToDo
//
//  Created by Илья Халяпин on 09.01.2018.
//  Copyright © 2018 Илья Халяпин. All rights reserved.
//

import Alamofire

extension API.Method.Lists {
    
    /// Получение списков
    @discardableResult
    static func list(appId: Int, token: String, completionHandler completion: @escaping (_ data: () throws -> API.Model.Lists.ListResponseModel) -> Void) -> Request {
        return API.Method.requestBuilder(resource: .listsList, appId: appId, token: token, completionHandler: completion)
    }
    
    /// Создание списка
    @discardableResult
    static func create(requestData data: API.Model.Lists.CreateRequestModel, appId: Int, token: String, completionHandler completion: @escaping (_ data: () throws -> API.Model.Lists.CreateResponseModel) -> Void) -> Request {
        return API.Method.requestBuilder(resource: .listsCreate, requestData: data, appId: appId, token: token, completionHandler: completion)
    }
    
    /// Изменение списка
    @discardableResult
    static func edit(requestData data: API.Model.Lists.EditRequestModel, appId: Int, token: String, completionHandler completion: @escaping (_ data: () throws -> API.Model.Lists.EditResponseModel) -> Void) -> Request {
        return API.Method.requestBuilder(resource: .listsEdit, requestData: data, appId: appId, token: token, completionHandler: completion)
    }
    
    /// Удаление списка
    @discardableResult
    static func delete(requestData data: API.Model.Lists.DeleteRequestModel, appId: Int, token: String, completionHandler completion: @escaping (_ data: API.Method.VoidResponse) -> Void) -> Request {
        return API.Method.requestBuilder(resource: .listsDelete, requestData: data, appId: appId, token: token, completionHandler: completion)
    }
    
}
