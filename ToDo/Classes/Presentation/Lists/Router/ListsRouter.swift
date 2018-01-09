//
//  ListsRouter.swift
//  ToDo
//
//  Created by Илья Халяпин on 10.01.2018.
//  Copyright © 2018 Илья Халяпин. All rights reserved.
//

import UIKit

final class ListsRouter: Router {
    
    // MARK: - Публичные свойства
    
    let storyboard = UIStoryboard(storyboard: .lists)
    
    weak var presenter: UIViewController?
    
    
    // MARK: - Инициализация
    
    required init(presenter: UIViewController?) {
        self.presenter = presenter
    }
    
}


// MARK: - Приватные свойства

private extension ListsRouter {
    
    /// Списки
    var listsViewController: ListsViewController {
        return viewController(ListsViewController.self)
    }
    
}


// MARK: - Переходы

extension ListsRouter {
    
    /// Отобразить списки
    func makeRootLists() {
        let listsViewController = self.listsViewController
        makeRoot(listsViewController)
    }
    
}
