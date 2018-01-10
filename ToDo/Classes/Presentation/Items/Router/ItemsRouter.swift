//
//  ItemsRouter.swift
//  ToDo
//
//  Created by Илья Халяпин on 10.01.2018.
//  Copyright © 2018 Илья Халяпин. All rights reserved.
//

import UIKit

final class ItemsRouter: Router {
    
    // MARK: - Публичные свойства
    
    let storyboard = UIStoryboard(storyboard: .items)
    
    weak var presenter: UIViewController?
    
    
    // MARK: - Инициализация
    
    required init(presenter: UIViewController?) {
        self.presenter = presenter
    }
    
}


// MARK: - Приватные свойства

private extension ItemsRouter {
    
    /// Записи
    var itemsViewController: ItemsViewController {
        return viewController(ItemsViewController.self)
    }
    
    /// Иформация о записи
    var itemDetailTableViewController: ItemDetailTableViewController {
        return viewController(ItemDetailTableViewController.self)
    }
    
}


// MARK: - Переходы

extension ItemsRouter {
    
    /// Отобразить записи
    func showItems(list: List) {
        let itemsViewController = self.itemsViewController
        itemsViewController.list = list
        
        show(itemsViewController)
    }
    
    /// Отобразить создание записи
    func presentModallyAddItem(listId: Int, delegate: ItemDetailTableViewControllerDelegate) {
        let itemDetailTableViewController = self.itemDetailTableViewController
        itemDetailTableViewController.delegate = delegate
        itemDetailTableViewController.listId = listId
        
        let navigationController = NavigationController(rootViewController: itemDetailTableViewController)
        presentModally(navigationController)
    }
    
    /// Отобразить редактирование записи
    func presentModallyEditItem(listId: Int, item: Item, delegate: ItemDetailTableViewControllerDelegate) {
        let itemDetailTableViewController = self.itemDetailTableViewController
        itemDetailTableViewController.delegate = delegate
        itemDetailTableViewController.listId = listId
        itemDetailTableViewController.item = item
        
        let navigationController = NavigationController(rootViewController: itemDetailTableViewController)
        presentModally(navigationController)
    }
    
    /// Отобразить HUD
    @discardableResult
    func presentModallyHUD(_ type: HUDContentType) -> HUDViewController {
        let otherRouter = OtherRouter(presenter: self.presenter)
        return otherRouter.presentModallyHUD(type)
    }
    
}
