//
//  IconsRouter.swift
//  ToDo
//
//  Created by Илья Халяпин on 10.01.2018.
//  Copyright © 2018 Илья Халяпин. All rights reserved.
//

import UIKit

final class IconsRouter: Router {
    
    // MARK: - Публичные свойства
    
    let storyboard = UIStoryboard(storyboard: .icons)
    
    weak var presenter: UIViewController?
    
    
    // MARK: - Инициализация
    
    required init(presenter: UIViewController?) {
        self.presenter = presenter
    }
    
}


// MARK: - Приватные свойства

private extension IconsRouter {
    
    /// Иконки
    var iconsViewController: IconsViewController {
        return viewController(IconsViewController.self)
    }
    
}


// MARK: - Переходы

extension IconsRouter {
    
    /// Отобразить иконки
    func presentModallyIcons(icons: [Icon], active: Icon, delegate: IconsViewControllerDelegate) {
        let iconsViewController = self.iconsViewController
        iconsViewController.delegate = delegate
        iconsViewController.icons = icons
        iconsViewController.active = active
        
        let navigationController = NavigationController(rootViewController: iconsViewController)
        presentModally(navigationController)
    }
    
}
