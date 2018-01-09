//
//  API+Resource.swift
//  ToDo
//
//  Created by Илья Халяпин on 09.01.2018.
//  Copyright © 2018 Илья Халяпин. All rights reserved.
//

extension API {
    
    /// Идентификаторы ресурсов API
    enum Resource: String {
        
        // MARK: Account
        
        /// Создание учетной записи пользователя
        case accountRegistration = "account/registration"
        /// Авторизация пользователя в приложении
        case accountLogin = "account/login"
        /// Выход из приложения
        case accountLogout = "account/logout"
        
        
        // MARK: Colors
        
        /// Получение цветов
        case colorsList = "colors/list"
        
        
        // MARK: Icons
        
        /// Получение иконок
        case iconsList = "icons/list"
        
        
        // MARK: Lists
        
        /// Получение списков
        case listsList = "lists/list"
        /// Создание списка
        case listsCreate = "lists/create"
        /// Изменение списка
        case listsEdit = "lists/edit"
        /// Удаление списка
        case listsDelete = "lists/delete"
        
        
        // MARK: Items
        
        /// Получение записей
        case itemsList = "items/list"
        /// Создание записи
        case itemsCreate = "items/create"
        /// Изменение записи
        case itemsEdit = "items/edit"
        /// Удаление записи
        case itemsDelete = "items/delete"
        
    }
    
}


// MARK: - Публичные свойства

extension API.Resource {
    
    /// Название ресурса
    var title: String {
        switch self {
        case .accountRegistration:
            return "Создание учетной записи пользователя"
        case .accountLogin:
            return "Авторизация пользователя в приложении"
        case .accountLogout:
            return "Выход из приложения"
            
        case .colorsList:
            return "Получение цветов"
            
        case .iconsList:
            return "Получение иконок"
            
        case .listsList:
            return "Получение списков"
        case .listsCreate:
            return "Создание списка"
        case .listsEdit:
            return "Изменение списка"
        case .listsDelete:
            return "Удаление списка"
            
        case .itemsList:
            return "Получение записей"
        case .itemsCreate:
            return "Создание записи"
        case .itemsEdit:
            return "Изменение записи"
        case .itemsDelete:
            return "Удаление записи"
        }
    }
    
}
