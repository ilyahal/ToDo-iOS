//
//  Router.swift
//  ToDo
//
//  Created by Илья Халяпин on 09.01.2018.
//  Copyright © 2018 Илья Халяпин. All rights reserved.
//

import UIKit

/// Протокол роутеров
protocol Router {
    
    // MARK: - Публичные свойства
    
    /// Файл story, в которой находятся отображаемые view controller'ы
    var storyboard: UIStoryboard { get }
    
    /// View controller, с которого осуществляется навигация (не обязателен, если роутер делает показ поверх (не push/не modal))
    weak var presenter: UIViewController? { get }
    
    
    // MARK: - Инициализация
    
    /**
     Инициализатор роутрера
     - parameter presenter: view controller, с которого осуществляется навигация
     */
    init(presenter: UIViewController?)
    
}


// MARK: - Основные методы показа view controller

extension Router {
    
    /// Создание view Controller указанного типа
    func viewController<T: UIViewController>(_ `class`: T.Type) -> T {
        return self.storyboard.instantiateViewController(T.self)
    }
    
    /// Выполнить переход к view controller и сделать его основным
    func makeRoot(_ viewController: UIViewController) {
        if let presenter = self.presenter, let navigationController = presenter.navigationController {
            navigationController.viewControllers.removeAll()
        }
        
        UIWindow.keyWindowTransit(to: viewController)
    }
    
    /**
     Push навигация
     - parameter viewController: view controller, который отобразится
     */
    func show(_ viewController: UIViewController) {
        guard let presenter = self.presenter else {
            makeRoot(viewController)
            return
        }
        
        presenter.show(viewController, sender: .none)
    }
    
    /**
     Замена всех view controller в стеке на новый
     - parameter viewController: view controller, который отобразится
     */
    func showOnly(_ viewController: UIViewController) {
        guard let presenter = self.presenter else {
            makeRoot(viewController)
            return
        }
        
        presenter.navigationController?.viewControllers = [ viewController ]
    }
    
    /**
     Modal навигация
     - parameter viewController: view controller, который отобразится
     */
    func presentModally(_ viewController: UIViewController) {
        guard let presenter = self.presenter else {
            makeRoot(viewController)
            return
        }
        
        presenter.present(viewController, animated: true)
    }
    
    /// Скрытие модального view controller
    func dismiss() {
        self.presenter?.dismiss(animated: true, completion: nil)
    }
    
    
    /// Переход к корневому экрану
    func popToRoot() {
        _ = self.presenter?.navigationController?.popToRootViewController(animated: true)
    }
    
}
