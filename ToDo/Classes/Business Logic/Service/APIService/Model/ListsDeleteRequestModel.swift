//
//  ListsDeleteRequestModel.swift
//  ToDo
//
//  Created by Илья Халяпин on 09.01.2018.
//  Copyright © 2018 Илья Халяпин. All rights reserved.
//

/// Модель параметров запроса "Удаление списка"
final class ListsDeleteRequestModel {
    
    // MARK: - Публичные свойства
    
    /// Идентификатор списка
    let listId: Int
    
    
    // MARK: - Инициализация
    
    /**
     Модель параметров запроса "Удаление списка"
     - parameter listId: Идентификатор списка
     */
    init(listId: Int) {
        self.listId = listId
    }
    
}


// MARK: - Публичные свойства

extension ListsDeleteRequestModel {
    
    /// Модель API
    var APIModel: API.Model.Lists.DeleteRequestModel {
        let model = API.Model.Lists.DeleteRequestModel(listId: self.listId)
        return model
    }
    
}
