//
//  APIModelAccount+LoginRequestModel.swift
//  ToDo
//
//  Created by Илья Халяпин on 09.01.2018.
//  Copyright © 2018 Илья Халяпин. All rights reserved.
//

import Alamofire

extension API.Model.Account {
    
    /// Модель параметров запроса "Авторизация пользователя в приложении"
    final class LoginRequestModel: API.RequestModel {
        
        // MARK: - RequestModel
        
        /// JSON с параметрами
        override var parameters: Parameters? {
            var nillableDictionary: [API.Argument : Any?] = [:]
            nillableDictionary[.email] = self.email
            nillableDictionary[.password] = self.password
            
            let json = API.Helper.rejectNil(API.Helper.translateKeys(nillableDictionary))
            return json
        }
        
        
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
    
}
