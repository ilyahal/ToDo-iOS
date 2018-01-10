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
    
    /// Иформация о списке
    var listDetailTableViewController: ListDetailTableViewController {
        return viewController(ListDetailTableViewController.self)
    }
    
}


// MARK: - Переходы

extension ListsRouter {
    
    /// Отобразить списки
    func makeRootLists() {
        let listsViewController = self.listsViewController
        
        let navigationControllre = NavigationController(rootViewController: listsViewController)
        makeRoot(navigationControllre)
    }
    
    /// Отобразить создание списка
    func presentModallyAddList(colors: [Color], icons: [Icon], delegate: ListDetailTableViewControllerDelegate) {
        let listDetailTableViewController = self.listDetailTableViewController
        listDetailTableViewController.delegate = delegate
        listDetailTableViewController.colors = colors
        listDetailTableViewController.icons = icons
        
        let navigationControllre = NavigationController(rootViewController: listDetailTableViewController)
        presentModally(navigationControllre)
    }
    
    /// Отобразить редактирование списка
    func presentModallyEditList(list: List, colors: [Color], icons: [Icon], delegate: ListDetailTableViewControllerDelegate) {
        let listDetailTableViewController = self.listDetailTableViewController
        listDetailTableViewController.delegate = delegate
        listDetailTableViewController.colors = colors
        listDetailTableViewController.icons = icons
        listDetailTableViewController.list = list
        
        let navigationControllre = NavigationController(rootViewController: listDetailTableViewController)
        presentModally(navigationControllre)
    }
    
    /// Отобразить HUD
    @discardableResult
    func presentModallyHUD(_ type: HUDContentType) -> HUDViewController {
        let otherRouter = OtherRouter(presenter: self.presenter)
        return otherRouter.presentModallyHUD(type)
    }
    
}
