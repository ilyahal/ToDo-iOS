//
//  ItemDetailTableViewControllerDelegate.swift
//  ToDo
//
//  Created by Илья Халяпин on 10.01.2018.
//  Copyright © 2018 Илья Халяпин. All rights reserved.
//

protocol ItemDetailTableViewControllerDelegate: class {
    
    /// Создан список
    func itemDetailTableViewController(_ itemDetailTableViewController: ItemDetailTableViewController, didCreate item: Item)
    /// Изменен список
    func itemDetailTableViewController(_ itemDetailTableViewController: ItemDetailTableViewController, didEdit item: Item)
    /// Отмена
    func itemDetailTableViewControllerCancel(_ itemDetailTableViewController: ItemDetailTableViewController)
    
}
