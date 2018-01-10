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
        
        let navigationController = NavigationController(rootViewController: listsViewController)
        makeRoot(navigationController)
    }
    
    /// Отобразить создание списка
    func presentModallyAddList(colors: [Color], icons: [Icon], delegate: ListDetailTableViewControllerDelegate) {
        let listDetailTableViewController = self.listDetailTableViewController
        listDetailTableViewController.delegate = delegate
        listDetailTableViewController.colors = colors
        listDetailTableViewController.icons = icons
        
        let navigationController = NavigationController(rootViewController: listDetailTableViewController)
        presentModally(navigationController)
    }
    
    /// Отобразить редактирование списка
    func presentModallyEditList(list: List, colors: [Color], icons: [Icon], delegate: ListDetailTableViewControllerDelegate) {
        let listDetailTableViewController = self.listDetailTableViewController
        listDetailTableViewController.delegate = delegate
        listDetailTableViewController.colors = colors
        listDetailTableViewController.icons = icons
        listDetailTableViewController.list = list
        
        let navigationController = NavigationController(rootViewController: listDetailTableViewController)
        presentModally(navigationController)
    }
    
    /// Отобразить HUD
    @discardableResult
    func presentModallyHUD(_ type: HUDContentType) -> HUDViewController {
        let otherRouter = OtherRouter(presenter: self.presenter)
        return otherRouter.presentModallyHUD(type)
    }
    
    /// Отобразить авторизацию
    func makeRootLogin() {
        let registrationRouter = RegistrationRouter(presenter: self.presenter)
        registrationRouter.makeRootLogin()
    }
    
    /// Отобразить цвета
    func presentModallyColors(colors: [Color], active: Color, delegate: ColorsViewControllerDelegate) {
        let colorsRouter = ColorsRouter(presenter: self.presenter)
        colorsRouter.presentModallyColors(colors: colors, active: active, delegate: delegate)
    }
    
    /// Отобразить иконки
    func presentModallyIcons(icons: [Icon], active: Icon, delegate: IconsViewControllerDelegate) {
        let iconsRouter = IconsRouter(presenter: self.presenter)
        iconsRouter.presentModallyIcons(icons: icons, active: active, delegate: delegate)
    }
    
    /// Отобразить записи
    func showItems(list: List) {
        let itemsRouter = ItemsRouter(presenter: self.presenter)
        itemsRouter.showItems(list: list)
    }
    
}
