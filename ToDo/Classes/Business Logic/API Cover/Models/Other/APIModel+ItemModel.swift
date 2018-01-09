//
//  APIModel+ItemModel.swift
//  ToDo
//
//  Created by Илья Халяпин on 09.01.2018.
//  Copyright © 2018 Илья Халяпин. All rights reserved.
//

import SwiftyJSON

extension API.Model {
    
    /// Модель записи
    final class ItemModel: API.Model {
        
        // MARK: - Публичные свойства
        
        /// Идентификатор записи
        let itemId: Int
        /// Идентификатор списка
        let listId: Int
        /// Заголовок
        let title: String
        /// Описание
        let description: String?
        /// Признак активности записи
        let isActive: Bool
        /// Дата добавления записи
        let insertDate: Date
        /// Дата обновления записи
        let updateDate: Date?
        
        
        // MARK: - Инициализация
        
        /**
         Модель записи
         - parameter json: JSON с необходимыми данными
         */
        init?(json: JSON) {
            guard let itemId = json[.itemId].int else { return nil }
            self.itemId = itemId
            guard let listId = json[.listId].int else { return nil }
            self.listId = listId
            guard let title = json[.title].string else { return nil }
            self.title = title
            self.description = json[.description].string
            guard let isActive = json[.isActive].bool else { return nil }
            self.isActive = isActive
            guard let insertDate = API.Helper.getDate(fromISO8601String: json[.insertDate].string) else { return nil }
            self.insertDate = insertDate
            self.updateDate = API.Helper.getDate(fromISO8601String: json[.updateDate].string)
        }
        
    }
    
}


// MARK: - Публичные свойства

extension API.Model.ItemModel {
    
    var entity: Item {
        return Item(itemId: self.itemId, listId: self.listId, title: self.title, description: description, isActive: isActive, insertDate: self.insertDate, updateDate: self.updateDate)
    }
    
}
