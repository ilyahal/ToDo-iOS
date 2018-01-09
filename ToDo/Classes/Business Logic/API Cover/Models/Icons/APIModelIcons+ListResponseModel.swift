//
//  APIModelIcons+ListResponseModel.swift
//  ToDo
//
//  Created by Илья Халяпин on 09.01.2018.
//  Copyright © 2018 Илья Халяпин. All rights reserved.
//

import SwiftyJSON

extension API.Model.Icons {
    
    /// Модель параметров ответа запроса "Получение иконок"
    final class ListResponseModel: API.ResponseModel {
        
        // MARK: - Публичные свойства
        
        /// Иконки
        let icons: [API.Model.IconModel]
        
        
        // MARK: - Инициализация
        
        /**
         Модель параметров ответа запроса "Получение иконок"
         - parameter json: JSON с необходимыми данными
         */
        required init?(json: JSON) {
            guard let iconsJSONArray = json.array else { return nil }
            let icons = iconsJSONArray.flatMap { API.Model.IconModel(json: $0) }
            self.icons = icons
            
            super.init()
        }
        
    }
    
}
