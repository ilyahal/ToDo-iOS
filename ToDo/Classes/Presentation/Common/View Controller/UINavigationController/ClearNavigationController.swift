//
//  ClearNavigationController.swift
//  ToDo
//
//  Created by Илья Халяпин on 10.01.2018.
//  Copyright © 2018 Илья Халяпин. All rights reserved.
//

import UIKit

final class ClearNavigationController: UINavigationController { }


// MARK: - UIViewController

extension ClearNavigationController {
    
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

private extension ClearNavigationController {
    
    /// Подготовка экрана
    func setup() {
        
        // Настройка навигационной панели
        configureNavigationBar()
    }
    
    /// Настройка навигационной панели
    func configureNavigationBar() {
        
        // Задний фон
        self.navigationBar.setBackgroundImage(UIImage.generate(with: .clear), for: .default)
        self.navigationBar.isTranslucent = true
        
        // Разделитель
        self.navigationBar.shadowImage = UIImage.generate(with: .clear)
        
        // Цвет кнопок
        self.navigationBar.tintColor = .white
        
        // Настройка заголовка
        let navigationBarTitleTextAttributes: [NSAttributedStringKey : Any] = [
            .foregroundColor: UIColor.white
        ]
        self.navigationBar.titleTextAttributes = navigationBarTitleTextAttributes
    }
    
}
