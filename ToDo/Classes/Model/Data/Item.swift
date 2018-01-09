//
//  Item.swift
//  ToDo
//
//  Created by Илья Халяпин on 09.01.2018.
//  Copyright © 2018 Илья Халяпин. All rights reserved.
//

import Foundation

/// Запись
final class Item: Entity {
    
    // MARK: - Публичные свойства
    
    /// Идентификатор записи
    let itemId: Int
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
    
    init(itemId: Int, title: String, description: String?, isActive: Bool, insertDate: Date, updateDate: Date?) {
        self.itemId = itemId
        self.title = title
        self.description = description
        self.isActive = isActive
        self.insertDate = insertDate
        self.updateDate = updateDate
    }
    
}
