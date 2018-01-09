//
//  APIModel+LoginInfoModel.swift
//  ToDo
//
//  Created by Илья Халяпин on 09.01.2018.
//  Copyright © 2018 Илья Халяпин. All rights reserved.
//

import SwiftyJSON

extension API.Model {
    
    /// Модель информации об регистрации
    final class LoginInfoModel: API.Model {
        
        // MARK: - Публичные свойства
        
        /// Уникальный идентификатор экземпляра приложения
        let appId: String
        /// Токен
        let token: String
        
        
        // MARK: - Инициализация
        
        /**
         Модель информации об регистрации
         - parameter json: JSON с необходимыми данными
         */
        init?(json: JSON) {
            guard let appId = json[.appId].string else { return nil }
            self.appId = appId
            guard let token = json[.token].string else { return nil }
            self.token = token
        }
        
    }
    
}


// MARK: - Публичные свойства

extension API.Model.LoginInfoModel {
    
    var entity: LoginInfo {
        return LoginInfo(appId: self.appId, token: self.token)
    }
    
}
