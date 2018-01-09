//
//  OtherRouter.swift
//  ToDo
//
//  Created by Илья Халяпин on 09.01.2018.
//  Copyright © 2018 Илья Халяпин. All rights reserved.
//

import UIKit

final class OtherRouter: Router {
    
    // MARK: - Публичные свойства
    
    let storyboard = UIStoryboard(storyboard: .other)
    
    weak var presenter: UIViewController?
    
    
    // MARK: - Инициализация
    
    required init(presenter: UIViewController?) {
        self.presenter = presenter
    }
    
}


// MARK: - Приватные свойства

private extension OtherRouter {
    
    /// HUD
    var hudViewController: HUDViewController {
        return viewController(HUDViewController.self)
    }
    
}


// MARK: - Переходы

extension OtherRouter {
    
    /// Отобразить HUD
    @discardableResult
    func presentModallyHUD(_ type: HUDContentType) -> HUDViewController {
        let hudViewController = self.hudViewController
        hudViewController.contentType = type
        
        presentModally(hudViewController)
        return hudViewController
    }
    
}
