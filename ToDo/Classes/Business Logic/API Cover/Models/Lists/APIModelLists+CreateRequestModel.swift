//
//  APIModelLists+CreateRequestModel.swift
//  ToDo
//
//  Created by Илья Халяпин on 09.01.2018.
//  Copyright © 2018 Илья Халяпин. All rights reserved.
//

import Alamofire

extension API.Model.Lists {
    
    /// Модель параметров запроса "Создание списка"
    final class CreateRequestModel: API.RequestModel {
        
        // MARK: - RequestModel
        
        /// JSON с параметрами
        override var parameters: Parameters? {
            var nillableDictionary: [API.Argument : Any?] = [:]
            nillableDictionary[.title] = self.title
            nillableDictionary[.description] = self.description
            nillableDictionary[.colorId] = self.colorId
            nillableDictionary[.iconId] = self.iconId
            
            let json = API.Helper.rejectNil(API.Helper.translateKeys(nillableDictionary))
            return json
        }
        
        
        // MARK: - Публичные свойства
        
        /// Заголовок
        let title: String
        /// Описание
        let description: String?
        /// Идентификатор цвета
        let colorId: Int
        /// Идентификатор иконки
        let iconId: Int
        
        
        // MARK: - Инициализация
        
        /**
         Модель параметров запроса "Создание списка"
         - parameter title: Заголовок
         - parameter description: Описание
         - parameter colorId: Идентификатор цвета
         - parameter iconId: Идентификатор иконки
         */
        init(title: String, description: String?, colorId: Int, iconId: Int) {
            self.title = title
            self.description = description
            self.colorId = colorId
            self.iconId = iconId
        }
        
    }
    
}
