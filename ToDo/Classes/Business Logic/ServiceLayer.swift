//
//  ServiceLayer.swift
//  ToDo
//
//  Created by Илья Халяпин on 09.01.2018.
//  Copyright © 2018 Илья Халяпин. All rights reserved.
//

import AlamofireNetworkActivityIndicator
import IQKeyboardManagerSwift

final class ServiceLayer {
    
    // MARK: - Shared instance
    
    static let instance = ServiceLayer()
    
    
    // MARK: - Публичные свойства
    
    /// Сервис настроек приложения
    let applicationSettingsService: ApplicationSettingsService
    /// Сервис API
    let apiService: APIService
    
    
    // MARK: - Инициализация
    
    private init() {
        
        // Автоматический ActivityIndicator при выполнении запросов Alamofire
        NetworkActivityIndicatorManager.shared.isEnabled = true
        NetworkActivityIndicatorManager.shared.startDelay = 0.5
        
        // Автоматическое управление клавиатурой
        IQKeyboardManager.sharedManager().enable = true
        IQKeyboardManager.sharedManager().toolbarDoneBarButtonItemText = "Готово"
        
        // Инициализация сервисов
        self.applicationSettingsService = ApplicationSettingsService()
        self.apiService = APIService(applicationSettingsService: self.applicationSettingsService)
    }
    
}
