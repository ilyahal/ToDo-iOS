//
//  List.swift
//  ToDo
//
//  Created by Илья Халяпин on 09.01.2018.
//  Copyright © 2018 Илья Халяпин. All rights reserved.
//

import Foundation

/// Список
final class List: Entity {
    
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
    
    init(listId: Int, title: String, description: String?, colorId: Int, iconId: Int, insertDate: Date, updateDate: Date?) {
        self.listId = listId
        self.title = title
        self.description = description
        self.colorId = colorId
        self.iconId = iconId
        self.insertDate = insertDate
        self.updateDate = updateDate
    }
    
}
