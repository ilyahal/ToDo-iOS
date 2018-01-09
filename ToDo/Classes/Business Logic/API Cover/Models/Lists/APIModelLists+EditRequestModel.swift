//
//  APIModelLists+EditRequestModel.swift
//  ToDo
//
//  Created by Илья Халяпин on 09.01.2018.
//  Copyright © 2018 Илья Халяпин. All rights reserved.
//

import Alamofire

extension API.Model.Lists {
    
    /// Модель параметров запроса "Изменение списка"
    final class EditRequestModel: API.RequestModel {
        
        // MARK: - RequestModel
        
        /// JSON с параметрами
        override var parameters: Parameters? {
            var nillableDictionary: [API.Argument : Any?] = [:]
            nillableDictionary[.listId] = self.listId
            nillableDictionary[.title] = self.title
            nillableDictionary[.description] = self.description
            nillableDictionary[.colorId] = self.colorId
            nillableDictionary[.iconId] = self.iconId
            
            let json = API.Helper.rejectNil(API.Helper.translateKeys(nillableDictionary))
            return json
        }
        
        
        // MARK: - Публичные свойства
        
        /// Идентификатор списка
        let listId: Int
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
         Модель параметров запроса "Изменение списка"
         - parameter listId: Идентификатор списка
         - parameter title: Заголовок
         - parameter description: Описание
         - parameter colorId: Идентификатор цвета
         - parameter iconId: Идентификатор иконки
         */
        init(listId: Int, title: String, description: String?, colorId: Int, iconId: Int) {
            self.listId = listId
            self.title = title
            self.description = description
            self.colorId = colorId
            self.iconId = iconId
        }
        
    }
    
}
