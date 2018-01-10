//
//  Color.swift
//  ToDo
//
//  Created by Илья Халяпин on 09.01.2018.
//  Copyright © 2018 Илья Халяпин. All rights reserved.
//

import Foundation

/// Цвет
final class Color: Entity {
    
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
    
    init(colorId: Int, red: Int, green: Int, blue: Int, insertDate: Date, updateDate: Date?) {
        self.colorId = colorId
        self.red = red
        self.green = green
        self.blue = blue
        self.insertDate = insertDate
        self.updateDate = updateDate
    }
    
}


// MARK: - Equatable

extension Color: Equatable {
    
    static func ==(lhs: Color, rhs: Color) -> Bool {
        return lhs.colorId == rhs.colorId
    }
    
}
