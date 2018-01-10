//
//  ColorsRouter.swift
//  ToDo
//
//  Created by Илья Халяпин on 10.01.2018.
//  Copyright © 2018 Илья Халяпин. All rights reserved.
//

import UIKit

final class ColorsRouter: Router {
    
    // MARK: - Публичные свойства
    
    let storyboard = UIStoryboard(storyboard: .colors)
    
    weak var presenter: UIViewController?
    
    
    // MARK: - Инициализация
    
    required init(presenter: UIViewController?) {
        self.presenter = presenter
    }
    
}


// MARK: - Приватные свойства

private extension ColorsRouter {
    
    /// Цвета
    var colorsViewController: ColorsViewController {
        return viewController(ColorsViewController.self)
    }
    
}


// MARK: - Переходы

extension ColorsRouter {
    
    /// Отобразить цвета
    func presentModallyColors(colors: [Color], active: Color, delegate: ColorsViewControllerDelegate) {
        let colorsViewController = self.colorsViewController
        colorsViewController.delegate = delegate
        colorsViewController.colors = colors
        colorsViewController.active = active
        
        let navigationController = NavigationController(rootViewController: colorsViewController)
        presentModally(navigationController)
    }
    
}
