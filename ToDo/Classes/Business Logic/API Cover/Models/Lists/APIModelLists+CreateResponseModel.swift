//
//  APIModelLists+CreateResponseModel.swift
//  ToDo
//
//  Created by Илья Халяпин on 09.01.2018.
//  Copyright © 2018 Илья Халяпин. All rights reserved.
//

import SwiftyJSON

extension API.Model.Lists {
    
    /// Модель параметров ответа запроса "Создание списка"
    final class CreateResponseModel: API.ResponseModel {
        
        // MARK: - Публичные свойства
        
        /// Список
        let list: API.Model.ListModel
        
        
        // MARK: - Инициализация
        
        /**
         Модель параметров ответа запроса "Создание списка"
         - parameter json: JSON с необходимыми данными
         */
        required init?(json: JSON) {
            guard let list = API.Model.ListModel(json: json) else { return nil }
            self.list = list
            
            super.init()
        }
        
    }
    
}
