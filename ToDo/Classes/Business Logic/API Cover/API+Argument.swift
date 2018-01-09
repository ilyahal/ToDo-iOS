//
//  API+Argument.swift
//  ToDo
//
//  Created by Илья Халяпин on 09.01.2018.
//  Copyright © 2018 Илья Халяпин. All rights reserved.
//

import SwiftyJSON

extension API {
    
    /// Параметры для методов API
    enum Argument: String {
        
        /// Сообщение об ошибке
        case message
        /// Идентификатор пользователя
        case userId = "user_id"
        /// Адрес электронной почты
        case email
        /// Пароль
        case password
        /// Уникальный идентификатор экземпляра приложения
        case appId = "app_id"
        /// Секретный ключ экземпляра приложения
        case token
        /// Дата добавления записи
        case insertDate = "insert_date"
        /// Дата обновления записи
        case updateDate = "update_date"
        /// Идентификатор цвета
        case colorId = "color_id"
        /// Красный
        case red
        /// Зеленый
        case green
        /// Синий
        case blue
        /// Идентификатор иконки
        case iconId = "icon_id"
        /// Название
        case name
        /// Идентификатор списка
        case listId = "list_id"
        /// Заголовок
        case title
        /// Описание
        case description
        /// Идентификатор записи
        case itemId = "item_id"
        /// Признак активности записи
        case isActive = "is_active"
        
    }
    
}


// MARK: - SwiftyJSON

extension JSON {
    
    subscript(path: API.Argument) -> JSON {
        get {
            return self[path.rawValue]
        }
        set {
            self[path.rawValue] = newValue
        }
    }
    
}
