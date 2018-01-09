//
//  APIModelColors+ListResponseModel.swift
//  ToDo
//
//  Created by Илья Халяпин on 09.01.2018.
//  Copyright © 2018 Илья Халяпин. All rights reserved.
//

import SwiftyJSON

extension API.Model.Colors {
    
    /// Модель параметров ответа запроса "Получение цветов"
    final class ListResponseModel: API.ResponseModel {
        
        // MARK: - Публичные свойства
        
        /// Цвета
        let colors: [API.Model.ColorModel]
        
        
        // MARK: - Инициализация
        
        /**
         Модель параметров ответа запроса "Получение цветов"
         - parameter json: JSON с необходимыми данными
         */
        required init?(json: JSON) {
            guard let colorsJSONArray = json.array else { return nil }
            let colors = colorsJSONArray.flatMap { API.Model.ColorModel(json: $0) }
            self.colors = colors
            
            super.init()
        }
        
    }
    
}
