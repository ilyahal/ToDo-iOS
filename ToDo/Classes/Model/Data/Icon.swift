//
//  Icon.swift
//  ToDo
//
//  Created by Илья Халяпин on 09.01.2018.
//  Copyright © 2018 Илья Халяпин. All rights reserved.
//

import Foundation

/// Иконка
final class Icon: Entity {
    
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
    
    init(iconId: Int, name: String, insertDate: Date, updateDate: Date?) {
        self.iconId = iconId
        self.name = name
        self.insertDate = insertDate
        self.updateDate = updateDate
    }
    
}


// MARK: - Equatable

extension Icon: Equatable {
    
    static func ==(lhs: Icon, rhs: Icon) -> Bool {
        return lhs.iconId == rhs.iconId
    }
    
}
