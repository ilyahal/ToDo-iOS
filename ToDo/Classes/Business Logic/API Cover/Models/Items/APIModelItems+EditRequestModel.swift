//
//  APIModelItems+EditRequestModel.swift
//  ToDo
//
//  Created by Илья Халяпин on 09.01.2018.
//  Copyright © 2018 Илья Халяпин. All rights reserved.
//

import Alamofire

extension API.Model.Items {
    
    /// Модель параметров запроса "Изменение записи"
    final class EditRequestModel: API.RequestModel {
        
        // MARK: - RequestModel
        
        /// JSON с параметрами
        override var parameters: Parameters? {
            var nillableDictionary: [API.Argument : Any?] = [:]
            nillableDictionary[.itemId] = self.itemId
            nillableDictionary[.title] = self.title
            nillableDictionary[.description] = self.description
            nillableDictionary[.isActive] = self.isActive
            
            let json = API.Helper.rejectNil(API.Helper.translateKeys(nillableDictionary))
            return json
        }
        
        
        // MARK: - Публичные свойства
        
        /// Идентификатор записи
        let itemId: Int
        /// Заголовок
        let title: String
        /// Описание
        let description: String?
        /// Признак активности записи
        let isActive: Bool
        
        
        // MARK: - Инициализация
        
        /**
         Модель параметров запроса "Изменение записи"
         - parameter itemId: Идентификатор записи
         - parameter title: Заголовок
         - parameter description: Описание
         - parameter isActive: Признак активности записи
         */
        init(itemId: Int, title: String, description: String?, isActive: Bool) {
            self.itemId = itemId
            self.title = title
            self.description = description
            self.isActive = isActive
        }
        
    }
    
}
