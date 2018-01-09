//
//  StartRouter.swift
//  ToDo
//
//  Created by Илья Халяпин on 09.01.2018.
//  Copyright © 2018 Илья Халяпин. All rights reserved.
//

import UIKit

final class StartRouter: Router {
    
    // MARK: - Публичные свойства
    
    let storyboard = UIStoryboard(storyboard: .start)
    
    weak var presenter: UIViewController?
    
    
    // MARK: - Инициализация
    
    required init(presenter: UIViewController?) {
        self.presenter = presenter
    }
    
}


// MARK: - Переходы

extension StartRouter {
    
    /// Отобразить авторизацию
    func makeRootLogin() {
        let registrationRouter = RegistrationRouter(presenter: self.presenter)
        registrationRouter.makeRootLogin()
    }
    
    /// Отобразить списки
    func makeRootLists() {
        let listsRouter = ListsRouter(presenter: self.presenter)
        listsRouter.makeRootLists()
    }
    
}
