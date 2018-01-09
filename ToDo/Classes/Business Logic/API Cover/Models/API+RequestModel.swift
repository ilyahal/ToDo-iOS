//
//  API+RequestModel.swift
//  ToDo
//
//  Created by Илья Халяпин on 09.01.2018.
//  Copyright © 2018 Илья Халяпин. All rights reserved.
//

import Alamofire

extension API {
    
    /// Модель параметров запроса
    class RequestModel: API.Model {
        
        // MARK: - Публичные свойства
        
        /// Путь
        var path: String? {
            return nil
        }
        
        /// Запрос
        var query: String? {
            return nil
        }
        
        /// JSON с параметрами
        var parameters: Parameters? {
            return nil
        }
        
    }
    
}


// MARK: - Публичные методы

extension API.RequestModel {
    
    /// Создание запроса
    static func createQuery(parameters: [(key: String, value: String)]) -> String {
        guard !parameters.isEmpty else { return .empty }
        var parameters = parameters
        
        let parameter = parameters.removeFirst()
        var result = "?\(parameter.key)=\(parameter.value)"
        
        result = parameters.reduce(result) { total, parameter in
            total + "&\(parameter.key)=\(parameter.value)"
        }
        
        return result
    }
    
}
