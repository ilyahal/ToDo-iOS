//
//  APIModelItems+ListRequestModel.swift
//  ToDo
//
//  Created by Илья Халяпин on 11.01.2018.
//  Copyright © 2018 Илья Халяпин. All rights reserved.
//

import Alamofire

extension API.Model.Items {
    
    /// Модель параметров запроса "Получение записей"
    final class ListRequestModel: API.RequestModel {
        
        // MARK: - RequestModel
        
        /// JSON с параметрами
        override var parameters: Parameters? {
            var nillableDictionary: [API.Argument : Any?] = [:]
            nillableDictionary[.listId] = self.listId
            
            let json = API.Helper.rejectNil(API.Helper.translateKeys(nillableDictionary))
            return json
        }
        
        
        // MARK: - Публичные свойства
        
        /// Идентификатор списка
        let listId: Int
        
        
        // MARK: - Инициализация
        
        /**
         Модель параметров запроса "Получение записей"
         - parameter itemId: Идентификатор списка
         */
        init(listId: Int) {
            self.listId = listId
        }
        
    }
    
}
