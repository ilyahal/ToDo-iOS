//
//  ItemsCreateRequestModel.swift
//  ToDo
//
//  Created by Илья Халяпин on 09.01.2018.
//  Copyright © 2018 Илья Халяпин. All rights reserved.
//

/// Модель параметров запроса "Создание записи"
final class ItemsCreateRequestModel {
    
    // MARK: - Публичные свойства
    
    /// Идентификатор списка
    let listId: Int
    /// Заголовок
    let title: String
    /// Описание
    let description: String?
    
    
    // MARK: - Инициализация
    
    /**
     Модель параметров запроса "Создание записи"
     - parameter listId: Идентификатор списка
     - parameter title: Заголовок
     - parameter description: Описание
     */
    init(listId: Int, title: String, description: String?) {
        self.listId = listId
        self.title = title
        self.description = description
    }
    
}


// MARK: - Публичные свойства

extension ItemsCreateRequestModel {
    
    /// Модель API
    var APIModel: API.Model.Items.CreateRequestModel {
        let model = API.Model.Items.CreateRequestModel(listId: self.listId, title: self.title, description: self.description)
        return model
    }
    
}
