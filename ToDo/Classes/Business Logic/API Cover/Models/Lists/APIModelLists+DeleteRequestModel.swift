//
//  APIModelLists+DeleteRequestModel.swift
//  ToDo
//
//  Created by Илья Халяпин on 09.01.2018.
//  Copyright © 2018 Илья Халяпин. All rights reserved.
//

import Alamofire

extension API.Model.Lists {
    
    /// Модель параметров запроса "Удаление списка"
    final class DeleteRequestModel: API.RequestModel {
        
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
         Модель параметров запроса "Удаление списка"
         - parameter listId: Идентификатор списка
         */
        init(listId: Int) {
            self.listId = listId
        }
        
    }
    
}
