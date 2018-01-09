//
//  APIModelItems+CreateRequestModel.swift
//  ToDo
//
//  Created by Илья Халяпин on 09.01.2018.
//  Copyright © 2018 Илья Халяпин. All rights reserved.
//

import Alamofire

extension API.Model.Items {
    
    /// Модель параметров запроса "Создание записи"
    final class CreateRequestModel: API.RequestModel {
        
        // MARK: - RequestModel
        
        /// JSON с параметрами
        override var parameters: Parameters? {
            var nillableDictionary: [API.Argument : Any?] = [:]
            nillableDictionary[.listId] = self.listId
            nillableDictionary[.title] = self.title
            nillableDictionary[.description] = self.description
            
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
        
        
        // MARK: - Инициализация
        
        /**
         Модель параметров запроса "Создание записи"
         - parameter listId: Идентификатор списка
         - parameter title: Заголовок
         - parameter description: Описание
         */
        init(listId: Int, title: String, description: String?) {
            self.listId = listId
            self.title = title
            self.description = description
        }
        
    }
    
}
