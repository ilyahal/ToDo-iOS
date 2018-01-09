//
//  API.swift
//  ToDo
//
//  Created by Илья Халяпин on 09.01.2018.
//  Copyright © 2018 Илья Халяпин. All rights reserved.
//

/// ToDo API
final class API {
    
    // MARK: - Публичные свойства
    
    /// Основной хост сервера API
    static var host: String!
    /// Версия протокола обмена данных
    static var ver: String!
    
    
    // MARK: - Инициализация
    
    private init() { }
    
}


// MARK: - Публичные свойства

extension API {
    
    /// Базовый URL
    static var baseURL: String {
        return self.host + self.ver
    }
    
}


// MARK: - Публичные методы

extension API {
    
    /**
     Инициализация API
     - parameter host: Основной хост сервера API
     - parameter ver: Версия протокола обмена данных
     */
    static func initialize(host: String, ver: String) {
        self.host = host
        self.ver = ver
    }
    
}
