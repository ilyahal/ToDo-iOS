//
//  ApplicationSettingsService.swift
//  ToDo
//
//  Created by Илья Халяпин on 09.01.2018.
//  Copyright © 2018 Илья Халяпин. All rights reserved.
//

import UIKit

/// Сервис настроек приложения
final class ApplicationSettingsService {
    
    // MARK: - Приватные свойства
    
    private let userDefaults: UserDefaults
    
    
    // MARK: - Инициализация
    
    init() {
        self.userDefaults = UserDefaults.standard
        configureDefaults(for: self.userDefaults)
    }
    
}


// MARK: - Публичные свойства

extension ApplicationSettingsService {
    
    /// Уникальный идентификатор экземпляра приложения
    var appId: String? {
        get {
            return self.userDefaults.string(forKey: SettingsKeys.appId)
        }
        set {
            let isEmpty = newValue?.isEmptyOrWhitespace ?? true
            let appId = isEmpty ? nil : newValue
            
            self.userDefaults.set(appId, forKey: SettingsKeys.appId)
        }
    }
    
    /// Токен
    var token: String? {
        get {
            return self.userDefaults.string(forKey: SettingsKeys.token)
        }
        set {
            let isEmpty = newValue?.isEmptyOrWhitespace ?? true
            let appSecret = isEmpty ? nil : newValue
            
            self.userDefaults.set(appSecret, forKey: SettingsKeys.token)
        }
    }
    
    /// Email
    var email: String? {
        get {
            return self.userDefaults.string(forKey: SettingsKeys.email)
        }
        set {
            let isEmpty = newValue?.isEmptyOrWhitespace ?? true
            let email = isEmpty ? nil : newValue
            
            self.userDefaults.set(email, forKey: SettingsKeys.email)
        }
    }
    
    /// Авторизован пользователь
    var isLogined: Bool {
        get {
            return self.userDefaults.bool(forKey: SettingsKeys.isLogined)
        }
        set {
            self.userDefaults.set(newValue, forKey: SettingsKeys.isLogined)
        }
    }
    
}


// MARK: - Приватные методы

private extension ApplicationSettingsService {
    
    /// Настройка дефолтных значений UserDefaults
    func configureDefaults(for userDefaults: UserDefaults) {
        let defaults: [String : Any] = [:]
        
        userDefaults.register(defaults: defaults)
    }
    
}


// MARK: - Типы данных

/// Ключи настроек
private enum SettingsKeys {
    
    /// Название сервиса
    private static let service = String(describing: ApplicationSettingsService.self)
    
    /// Email
    static let email = service + ".email"
    
    /// Уникальный идентификатор экземпляра приложения
    static let appId = service + ".app-id"
    
    /// Токен
    static let token = service + ".token"
    
    /// Авторизован пользователь
    static let isLogined = service + ".is-logined"
    
}
