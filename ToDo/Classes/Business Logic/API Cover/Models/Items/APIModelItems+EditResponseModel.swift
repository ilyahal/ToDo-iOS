//
//  APIModelItems+EditResponseModel.swift
//  ToDo
//
//  Created by Илья Халяпин on 09.01.2018.
//  Copyright © 2018 Илья Халяпин. All rights reserved.
//

import SwiftyJSON

extension API.Model.Items {
    
    /// Модель параметров ответа запроса "Изменение записи"
    final class EditResponseModel: API.ResponseModel {
        
        // MARK: - Публичные свойства
        
        /// Запись
        let item: API.Model.ItemModel
        
        
        // MARK: - Инициализация
        
        /**
         Модель параметров ответа запроса "Изменение записи"
         - parameter json: JSON с необходимыми данными
         */
        required init?(json: JSON) {
            guard let item = API.Model.ItemModel(json: json) else { return nil }
            self.item = item
            
            super.init()
        }
        
    }
    
}
