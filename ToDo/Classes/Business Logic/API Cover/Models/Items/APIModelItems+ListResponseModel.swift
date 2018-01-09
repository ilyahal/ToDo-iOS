//
//  APIModelItems+ListResponseModel.swift
//  ToDo
//
//  Created by Илья Халяпин on 09.01.2018.
//  Copyright © 2018 Илья Халяпин. All rights reserved.
//

import SwiftyJSON

extension API.Model.Items {
    
    /// Модель параметров ответа запроса "Получение записей"
    final class ListResponseModel: API.ResponseModel {
        
        // MARK: - Публичные свойства
        
        /// Записи
        let items: [API.Model.ItemModel]
        
        
        // MARK: - Инициализация
        
        /**
         Модель параметров ответа запроса "Получение записей"
         - parameter json: JSON с необходимыми данными
         */
        required init?(json: JSON) {
            guard let itemsJSONArray = json.array else { return nil }
            let items = itemsJSONArray.flatMap { API.Model.ItemModel(json: $0) }
            self.items = items
            
            super.init()
        }
        
    }
    
}
