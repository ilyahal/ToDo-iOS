//
//  UIStoryboard+Storyboards.swift
//  ToDo
//
//  Created by Илья Халяпин on 09.01.2018.
//  Copyright © 2018 Илья Халяпин. All rights reserved.
//

import UIKit

extension UIStoryboard {
    
    /// Файлы story
    enum Storyboard: String {
        
        /// Прочее
        case other = "Other"
        /// Старт
        case start = "Start"
        /// Регистрация
        case registration = "Registration"
        /// Списки
        case lists = "Lists"
        /// Цвета
        case colors = "Colors"
        /// Иконки
        case icons = "Icons"
        /// Записи
        case items = "Items"
        
    }
    
}
