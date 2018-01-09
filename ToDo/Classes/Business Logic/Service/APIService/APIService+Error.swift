//
//  APIService+Error.swift
//  ToDo
//
//  Created by Илья Халяпин on 09.01.2018.
//  Copyright © 2018 Илья Халяпин. All rights reserved.
//

extension APIService {
    
    enum Error: Swift.Error {
        
        /// Запрос отменен
        case cancelled
        /// Завершено с ошибкой
        case failed(error: API.Error, message: String)
        
    }
    
}
