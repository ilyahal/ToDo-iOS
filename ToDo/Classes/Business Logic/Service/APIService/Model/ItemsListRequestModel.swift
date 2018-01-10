//
//  ItemsListRequestModel.swift
//  ToDo
//
//  Created by Илья Халяпин on 11.01.2018.
//  Copyright © 2018 Илья Халяпин. All rights reserved.
//

/// Модель параметров запроса "Получение записей"
final class ItemsListRequestModel {
    
    // MARK: - Публичные свойства
    
    /// Идентификатор списка
    let listId: Int
    
    
    // MARK: - Инициализация
    
    /**
     Модель параметров запроса "Получение записей"
     - parameter itemId: Идентификатор списка
     */
    init(listId: Int) {
        self.listId = listId
    }
    
}


// MARK: - Публичные свойства

extension ItemsListRequestModel {
    
    /// Модель API
    var APIModel: API.Model.Items.ListRequestModel {
        let model = API.Model.Items.ListRequestModel(listId: self.listId)
        return model
    }
    
}
