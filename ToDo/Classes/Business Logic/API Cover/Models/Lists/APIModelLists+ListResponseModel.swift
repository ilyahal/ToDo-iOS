//
//  APIModelLists+ListResponseModel.swift
//  ToDo
//
//  Created by Илья Халяпин on 09.01.2018.
//  Copyright © 2018 Илья Халяпин. All rights reserved.
//

import SwiftyJSON

extension API.Model.Lists {
    
    /// Модель параметров ответа запроса "Получение списков"
    final class ListResponseModel: API.ResponseModel {
        
        // MARK: - Публичные свойства
        
        /// Списки
        let lists: [API.Model.ListModel]
        
        
        // MARK: - Инициализация
        
        /**
         Модель параметров ответа запроса "Получение списков"
         - parameter json: JSON с необходимыми данными
         */
        required init?(json: JSON) {
            guard let listsJSONArray = json.array else { return nil }
            let lists = listsJSONArray.flatMap { API.Model.ListModel(json: $0) }
            self.lists = lists
            
            super.init()
        }
        
    }
    
}
