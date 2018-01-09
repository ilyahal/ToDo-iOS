//
//  AccountRegistrationRequestModel.swift
//  ToDo
//
//  Created by Илья Халяпин on 09.01.2018.
//  Copyright © 2018 Илья Халяпин. All rights reserved.
//

/// Модель параметров запроса "Создание учетной записи пользователя"
final class AccountRegistrationRequestModel {
    
    // MARK: - Публичные свойства
    
    /// Адрес электронной почты
    let email: String
    /// Пароль
    let password: String
    
    
    // MARK: - Инициализация
    
    /**
     Модель параметров запроса "Создание учетной записи пользователя"
     - parameter email: Адрес электронной почты
     - parameter password: Пароль
     */
    init(email: String, password: String) {
        self.email = email
        self.password = password
    }
    
}


// MARK: - Публичные свойства

extension AccountRegistrationRequestModel {
    
    /// Модель API
    var APIModel: API.Model.Account.RegistrationRequestModel {
        let model = API.Model.Account.RegistrationRequestModel(email: self.email, password: self.password)
        return model
    }
    
}
