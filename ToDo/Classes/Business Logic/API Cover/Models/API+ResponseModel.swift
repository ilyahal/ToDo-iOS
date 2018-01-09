//
//  API+ResponseModel.swift
//  ToDo
//
//  Created by Илья Халяпин on 09.01.2018.
//  Copyright © 2018 Илья Халяпин. All rights reserved.
//

import SwiftyJSON

extension API {
    
    /// Модель параметров ответа
    class ResponseModel: API.Model {
        
        // MARK: - Инициализация
        
        /// Модель параметров запроса
        override init() { }
        
        /**
         Модель параметров запроса
         - parameter json: JSON с необходимыми данными
         */
        required init?(json: JSON) { }
        
    }
    
}
