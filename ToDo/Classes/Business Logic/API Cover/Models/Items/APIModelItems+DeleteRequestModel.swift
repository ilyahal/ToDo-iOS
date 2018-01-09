//
//  APIModelItems+DeleteRequestModel.swift
//  ToDo
//
//  Created by Илья Халяпин on 09.01.2018.
//  Copyright © 2018 Илья Халяпин. All rights reserved.
//

import Alamofire

extension API.Model.Items {
    
    /// Модель параметров запроса "Удаление записи"
    final class DeleteRequestModel: API.RequestModel {
        
        // MARK: - RequestModel
        
        /// JSON с параметрами
        override var parameters: Parameters? {
            var nillableDictionary: [API.Argument : Any?] = [:]
            nillableDictionary[.itemId] = self.itemId
            
            let json = API.Helper.rejectNil(API.Helper.translateKeys(nillableDictionary))
            return json
        }
        
        
        // MARK: - Публичные свойства
        
        /// Идентификатор записи
        let itemId: Int
        
        
        // MARK: - Инициализация
        
        /**
         Модель параметров запроса "Удаление записи"
         - parameter itemId: Идентификатор записи
         */
        init(itemId: Int) {
            self.itemId = itemId
        }
        
    }
    
}
