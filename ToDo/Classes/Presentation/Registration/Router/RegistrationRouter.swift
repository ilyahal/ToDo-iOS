//
//  RegistrationRouter.swift
//  ToDo
//
//  Created by Илья Халяпин on 09.01.2018.
//  Copyright © 2018 Илья Халяпин. All rights reserved.
//

import UIKit

final class RegistrationRouter: Router {
    
    // MARK: - Публичные свойства
    
    let storyboard = UIStoryboard(storyboard: .registration)
    
    weak var presenter: UIViewController?
    
    
    // MARK: - Инициализация
    
    required init(presenter: UIViewController?) {
        self.presenter = presenter
    }
    
}


// MARK: - Приватные свойства

private extension RegistrationRouter {
    
    /// Авторизация
    var loginViewController: LoginViewController {
        return viewController(LoginViewController.self)
    }
    
    /// Регистрация
    var registrationViewController: RegistrationViewController {
        return viewController(RegistrationViewController.self)
    }
    
}


// MARK: - Переходы

extension RegistrationRouter {
    
    /// Отобразить авторизацию
    func makeRootLogin() {
        let loginViewController = self.loginViewController
        let navigationController = ClearNavigationController(rootViewController: loginViewController)
        
        makeRoot(navigationController)
    }
    
    /// Отобразить регистрацию
    func showRegistration() {
        let registrationViewController = self.registrationViewController
        show(registrationViewController)
    }
    
    /// Отобразить HUD
    @discardableResult
    func presentModallyHUD(_ type: HUDContentType) -> HUDViewController {
        let otherRouter = OtherRouter(presenter: self.presenter)
        return otherRouter.presentModallyHUD(type)
    }
    
    /// Отобразить списки
    func makeRootLists() {
        let listsRouter = ListsRouter(presenter: self.presenter)
        listsRouter.makeRootLists()
    }
    
}
