//
//  APIModel+ErrorModel.swift
//  ToDo
//
//  Created by Илья Халяпин on 09.01.2018.
//  Copyright © 2018 Илья Халяпин. All rights reserved.
//

import SwiftyJSON

extension API.Model {
    
    /// Модель ошибки
    final class ErrorModel: API.Model {
        
        // MARK: - Публичные свойства
        
        /// Сообщение об ошибке
        let message: String
        
        
        // MARK: - Инициализация
        
        /**
         Модель ошибки
         - parameter json: JSON с необходимыми данными
         */
        init?(json: JSON) {
            guard let message = json[.message].string else { return nil }
            self.message = message
        }
        
    }
    
}
