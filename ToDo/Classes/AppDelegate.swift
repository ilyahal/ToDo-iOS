//
//  AppDelegate.swift
//  ToDo
//
//  Created by Илья Халяпин on 07.01.2018.
//  Copyright © 2018 Илья Халяпин. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // MARK: - Публичные свойства
    
    var window: UIWindow?
    
    
    // MARK: - UIApplicationDelegate
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        /// Настройка StatusBar
        application.statusBarStyle = .lightContent
        
        /// Инициализация сервисов
        let _ = ServiceLayer.instance
        
        return true
    }
    
}
