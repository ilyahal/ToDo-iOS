//
//  APIModel+IconModel.swift
//  ToDo
//
//  Created by Илья Халяпин on 09.01.2018.
//  Copyright © 2018 Илья Халяпин. All rights reserved.
//

import SwiftyJSON

extension API.Model {
    
    /// Модель иконки
    final class IconModel: API.Model {
        
        // MARK: - Публичные свойства
        
        /// Идентификатор иконки
        let iconId: Int
        /// Название
        let name: String
        /// Дата добавления записи
        let insertDate: Date
        /// Дата обновления записи
        let updateDate: Date?
        
        
        // MARK: - Инициализация
        
        /**
         Модель иконки
         - parameter json: JSON с необходимыми данными
         */
        init?(json: JSON) {
            guard let iconId = json[.iconId].int else { return nil }
            self.iconId = iconId
            guard let name = json[.name].string else { return nil }
            self.name = name
            guard let insertDate = API.Helper.getDate(fromISO8601String: json[.insertDate].string) else { return nil }
            self.insertDate = insertDate
            self.updateDate = API.Helper.getDate(fromISO8601String: json[.updateDate].string)
        }
        
    }
    
}


// MARK: - Публичные свойства

extension API.Model.IconModel {
    
    var entity: Icon {
        return Icon(iconId: self.iconId, name: self.name, insertDate: self.insertDate, updateDate: self.updateDate)
    }
    
}
