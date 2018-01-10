//
//  APIMethod+APIMethod+Items.swift
//  ToDo
//
//  Created by Илья Халяпин on 09.01.2018.
//  Copyright © 2018 Илья Халяпин. All rights reserved.
//

import Alamofire

extension API.Method.Items {
    
    /// Получение записей
    @discardableResult
    static func list(requestData data: API.Model.Items.ListRequestModel, appId: Int, token: String, completionHandler completion: @escaping (_ data: () throws -> API.Model.Items.ListResponseModel) -> Void) -> Request {
        return API.Method.requestBuilder(resource: .itemsList, requestData: data, appId: appId, token: token, completionHandler: completion)
    }
    
    /// Создание записи
    @discardableResult
    static func create(requestData data: API.Model.Items.CreateRequestModel, appId: Int, token: String, completionHandler completion: @escaping (_ data: () throws -> API.Model.Items.CreateResponseModel) -> Void) -> Request {
        return API.Method.requestBuilder(resource: .itemsCreate, requestData: data, appId: appId, token: token, completionHandler: completion)
    }
    
    /// Изменение записи
    @discardableResult
    static func edit(requestData data: API.Model.Items.EditRequestModel, appId: Int, token: String, completionHandler completion: @escaping (_ data: () throws -> API.Model.Items.EditResponseModel) -> Void) -> Request {
        return API.Method.requestBuilder(resource: .itemsEdit, requestData: data, appId: appId, token: token, completionHandler: completion)
    }
    
    /// Удаление записи
    @discardableResult
    static func delete(requestData data: API.Model.Items.DeleteRequestModel, appId: Int, token: String, completionHandler completion: @escaping (_ data: API.Method.VoidResponse) -> Void) -> Request {
        return API.Method.requestBuilder(resource: .itemsDelete, requestData: data, appId: appId, token: token, completionHandler: completion)
    }
    
}
