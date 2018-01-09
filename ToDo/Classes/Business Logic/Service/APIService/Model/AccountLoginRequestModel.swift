//
//  AccountLoginRequestModel.swift
//  ToDo
//
//  Created by Илья Халяпин on 09.01.2018.
//  Copyright © 2018 Илья Халяпин. All rights reserved.
//

/// Модель параметров запроса "Авторизация пользователя в приложении"
final class AccountLoginRequestModel {
    
    // MARK: - Публичные свойства
    
    /// Адрес электронной почты
    let email: String
    /// Пароль
    let password: String
    
    
    // MARK: - Инициализация
    
    /**
     Модель параметров запроса "Авторизация пользователя в приложении"
     - parameter email: Адрес электронной почты
     - parameter password: Пароль
     */
    init(email: String, password: String) {
        self.email = email
        self.password = password
    }
    
}


// MARK: - Публичные свойства

extension AccountLoginRequestModel {
    
    /// Модель API
    var APIModel: API.Model.Account.LoginRequestModel {
        let model = API.Model.Account.LoginRequestModel(email: self.email, password: self.password)
        return model
    }
    
}
