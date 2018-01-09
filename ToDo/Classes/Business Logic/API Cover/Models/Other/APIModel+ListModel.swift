//
//  APIModel+ListModel.swift
//  ToDo
//
//  Created by Илья Халяпин on 09.01.2018.
//  Copyright © 2018 Илья Халяпин. All rights reserved.
//

import SwiftyJSON

extension API.Model {
    
    /// Модель списка
    final class ListModel: API.Model {
        
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
        /// Дата добавления записи
        let insertDate: Date
        /// Дата обновления записи
        let updateDate: Date?
        
        
        // MARK: - Инициализация
        
        /**
         Модель списка
         - parameter json: JSON с необходимыми данными
         */
        init?(json: JSON) {
            guard let listId = json[.listId].int else { return nil }
            self.listId = listId
            guard let title = json[.title].string else { return nil }
            self.title = title
            self.description = json[.description].string
            guard let colorId = json[.colorId].int else { return nil }
            self.colorId = colorId
            guard let iconId = json[.iconId].int else { return nil }
            self.iconId = iconId
            guard let insertDate = API.Helper.getDate(fromISO8601String: json[.insertDate].string) else { return nil }
            self.insertDate = insertDate
            self.updateDate = API.Helper.getDate(fromISO8601String: json[.updateDate].string)
        }
        
    }
    
}


// MARK: - Публичные свойства

extension API.Model.ListModel {
    
    var entity: List {
        return List(listId: self.listId, title: self.title, description: description, colorId: colorId, iconId: iconId, insertDate: self.insertDate, updateDate: self.updateDate)
    }
    
}
