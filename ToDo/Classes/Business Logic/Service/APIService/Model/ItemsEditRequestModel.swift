//
//  ItemsEditRequestModel.swift
//  ToDo
//
//  Created by Илья Халяпин on 09.01.2018.
//  Copyright © 2018 Илья Халяпин. All rights reserved.
//

/// Модель параметров запроса "Изменение записи"
final class ItemsEditRequestModel {
    
    // MARK: - Публичные свойства
    
    /// Идентификатор записи
    let itemId: Int
    /// Заголовок
    let title: String
    /// Описание
    let description: String?
    /// Признак активности записи
    let isActive: Bool
    
    
    // MARK: - Инициализация
    
    /**
     Модель параметров запроса "Изменение записи"
     - parameter itemId: Идентификатор записи
     - parameter title: Заголовок
     - parameter description: Описание
     - parameter isActive: Признак активности записи
     */
    init(itemId: Int, title: String, description: String?, isActive: Bool) {
        self.itemId = itemId
        self.title = title
        self.description = description
        self.isActive = isActive
    }
    
}


// MARK: - Публичные свойства

extension ItemsEditRequestModel {
    
    /// Модель API
    var APIModel: API.Model.Items.EditRequestModel {
        let model = API.Model.Items.EditRequestModel(itemId: self.itemId, title: self.title, description: self.description, isActive: self.isActive)
        return model
    }
    
}
