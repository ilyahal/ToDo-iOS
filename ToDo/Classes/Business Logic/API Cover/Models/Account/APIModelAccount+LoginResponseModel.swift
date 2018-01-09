//
//  APIModelAccount+LoginResponseModel.swift
//  ToDo
//
//  Created by Илья Халяпин on 09.01.2018.
//  Copyright © 2018 Илья Халяпин. All rights reserved.
//

import SwiftyJSON

extension API.Model.Account {
    
    /// Модель параметров ответа запроса "Подтверждение учетной записи пользователя"
    final class LoginResponseModel: API.ResponseModel {
        
        // MARK: - Публичные свойства
        
        /// Информация о пользователе
        let loginInfo: API.Model.LoginInfoModel
        
        
        // MARK: - Инициализация
        
        /**
         Модель параметров ответа запроса "Подтверждение учетной записи пользователя"
         - parameter json: JSON с необходимыми данными
         */
        required init?(json: JSON) {
            guard let loginInfo = API.Model.LoginInfoModel(json: json) else { return nil }
            self.loginInfo = loginInfo
            
            super.init()
        }
        
    }
    
}
