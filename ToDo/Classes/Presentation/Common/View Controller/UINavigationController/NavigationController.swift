//
//  NavigationController.swift
//  ToDo
//
//  Created by Илья Халяпин on 10.01.2018.
//  Copyright © 2018 Илья Халяпин. All rights reserved.
//

import UIKit

final class NavigationController: UINavigationController { }


// MARK: - UIViewController

extension NavigationController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Подготовка экрана
        setup()
    }
    
}


// MARK: - Приватные методы

private extension NavigationController {
    
    /// Подготовка экрана
    func setup() {
        
        // Настройка навигационной панели
        configureNavigationBar()
    }
    
    /// Настройка навигационной панели
    func configureNavigationBar() {
        
        // Задний фон
        self.navigationBar.setBackgroundImage(.generate(with: #colorLiteral(red: 0, green: 0.7222121358, blue: 0.9383115172, alpha: 1)), for: .default)
        
        // Цвет кнопок
        self.navigationBar.tintColor = .white
        
        // Настройка заголовка
        let navigationBarTitleTextAttributes: [NSAttributedStringKey : Any] = [
            .foregroundColor: UIColor.white
        ]
        self.navigationBar.titleTextAttributes = navigationBarTitleTextAttributes
    }
    
}
