//
//  LoginInfo.swift
//  ToDo
//
//  Created by Илья Халяпин on 09.01.2018.
//  Copyright © 2018 Илья Халяпин. All rights reserved.
//

/// Информация об авторизации
final class LoginInfo {
    
    // MARK: - Публичные свойства
    
    /// Уникальный идентификатор экземпляра приложения
    let appId: String
    /// Секретный ключ экземпляра приложения
    let token: String
    
    
    // MARK: - Инициализация объекта
    
    init(appId: String, token: String) {
        self.appId = appId
        self.token = token
    }
    
}
