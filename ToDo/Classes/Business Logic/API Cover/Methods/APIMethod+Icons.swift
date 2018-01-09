//
//  APIMethod+Icons.swift
//  ToDo
//
//  Created by Илья Халяпин on 09.01.2018.
//  Copyright © 2018 Илья Халяпин. All rights reserved.
//

import Alamofire

extension API.Method.Icons {
    
    /// Получение иконок
    @discardableResult
    static func list(completionHandler completion: @escaping (_ data: () throws -> API.Model.Icons.ListResponseModel) -> Void) -> Request {
        return API.Method.requestBuilder(resource: .iconsList, completionHandler: completion)
    }
    
}
