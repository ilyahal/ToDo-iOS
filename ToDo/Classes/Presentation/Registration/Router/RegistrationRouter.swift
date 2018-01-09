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
    
    /// Регистрация
    var registrationViewController: RegistrationViewController {
        return viewController(RegistrationViewController.self)
    }
    
}


// MARK: - Переходы

extension RegistrationRouter {
    
    /// Отобразить регистрацию
    func makeRootRegistration() {
        let registrationViewController = self.registrationViewController
        makeRoot(registrationViewController)
    }
    
}
