//
//  ListsCreateRequestModel.swift
//  ToDo
//
//  Created by Илья Халяпин on 09.01.2018.
//  Copyright © 2018 Илья Халяпин. All rights reserved.
//

/// Модель параметров запроса "Создание списка"
final class ListsCreateRequestModel {
    
    // MARK: - Публичные свойства
    
    /// Заголовок
    let title: String
    /// Описание
    let description: String?
    /// Идентификатор цвета
    let colorId: Int
    /// Идентификатор иконки
    let iconId: Int
    
    
    // MARK: - Инициализация
    
    /**
     Модель параметров запроса "Создание списка"
     - parameter title: Заголовок
     - parameter description: Описание
     - parameter colorId: Идентификатор цвета
     - parameter iconId: Идентификатор иконки
     */
    init(title: String, description: String?, colorId: Int, iconId: Int) {
        self.title = title
        self.description = description
        self.colorId = colorId
        self.iconId = iconId
    }
    
}


// MARK: - Публичные свойства

extension ListsCreateRequestModel {
    
    /// Модель API
    var APIModel: API.Model.Lists.CreateRequestModel {
        let model = API.Model.Lists.CreateRequestModel(title: self.title, description: self.description, colorId: self.colorId, iconId: iconId)
        return model
    }
    
}
