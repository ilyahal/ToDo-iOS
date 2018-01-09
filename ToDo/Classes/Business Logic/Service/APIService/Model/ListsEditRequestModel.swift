//
//  ListsEditRequestModel.swift
//  ToDo
//
//  Created by Илья Халяпин on 09.01.2018.
//  Copyright © 2018 Илья Халяпин. All rights reserved.
//

/// Модель параметров запроса "Изменение списка"
final class ListsEditRequestModel {
    
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
    
    
    // MARK: - Инициализация
    
    /**
     Модель параметров запроса "Изменение списка"
     - parameter listId: Идентификатор списка
     - parameter title: Заголовок
     - parameter description: Описание
     - parameter colorId: Идентификатор цвета
     - parameter iconId: Идентификатор иконки
     */
    init(listId: Int, title: String, description: String?, colorId: Int, iconId: Int) {
        self.listId = listId
        self.title = title
        self.description = description
        self.colorId = colorId
        self.iconId = iconId
    }
    
}


// MARK: - Публичные свойства

extension ListsEditRequestModel {
    
    /// Модель API
    var APIModel: API.Model.Lists.EditRequestModel {
        let model = API.Model.Lists.EditRequestModel(listId: self.listId, title: self.title, description: self.description, colorId: self.colorId, iconId: iconId)
        return model
    }
    
}
