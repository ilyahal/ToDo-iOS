//
//  APIModel+ColorModel.swift
//  ToDo
//
//  Created by Илья Халяпин on 09.01.2018.
//  Copyright © 2018 Илья Халяпин. All rights reserved.
//

import SwiftyJSON

extension API.Model {
    
    /// Модель цвета
    final class ColorModel: API.Model {
        
        // MARK: - Публичные свойства
        
        /// Идентификатор цвета
        let colorId: Int
        /// Красный
        let red: Int
        /// Зеленый
        let green: Int
        /// Синий
        let blue: Int
        /// Дата добавления записи
        let insertDate: Date
        /// Дата обновления записи
        let updateDate: Date?
        
        
        // MARK: - Инициализация
        
        /**
         Модель цвета
         - parameter json: JSON с необходимыми данными
         */
        init?(json: JSON) {
            guard let colorId = json[.colorId].int else { return nil }
            self.colorId = colorId
            guard let red = json[.red].int else { return nil }
            self.red = red
            guard let green = json[.green].int else { return nil }
            self.green = green
            guard let blue = json[.blue].int else { return nil }
            self.blue = blue
            guard let insertDate = API.Helper.getDate(fromISO8601String: json[.insertDate].string) else { return nil }
            self.insertDate = insertDate
            self.updateDate = API.Helper.getDate(fromISO8601String: json[.updateDate].string)
        }
        
    }
    
}


// MARK: - Публичные свойства

extension API.Model.ColorModel {
    
    var entity: Color {
        return Color(colorId: self.colorId, red: self.red, green: self.green, blue: self.blue, insertDate: self.insertDate, updateDate: self.updateDate)
    }
    
}
