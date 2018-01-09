//
//  ItemsDeleteRequestModel.swift
//  ToDo
//
//  Created by Илья Халяпин on 09.01.2018.
//  Copyright © 2018 Илья Халяпин. All rights reserved.
//

/// Модель параметров запроса "Удаление записи"
final class ItemsDeleteRequestModel {
    
    // MARK: - Публичные свойства
    
    /// Идентификатор записи
    let itemId: Int
    
    
    // MARK: - Инициализация
    
    /**
     Модель параметров запроса "Удаление записи"
     - parameter itemId: Идентификатор записи
     */
    init(itemId: Int) {
        self.itemId = itemId
    }
    
}


// MARK: - Публичные свойства

extension ItemsDeleteRequestModel {
    
    /// Модель API
    var APIModel: API.Model.Items.DeleteRequestModel {
        let model = API.Model.Items.DeleteRequestModel(itemId: self.itemId)
        return model
    }
    
}
