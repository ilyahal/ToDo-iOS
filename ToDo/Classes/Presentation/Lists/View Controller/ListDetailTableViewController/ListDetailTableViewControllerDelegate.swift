//
//  ListDetailTableViewControllerDelegate.swift
//  ToDo
//
//  Created by Илья Халяпин on 10.01.2018.
//  Copyright © 2018 Илья Халяпин. All rights reserved.
//

protocol ListDetailTableViewControllerDelegate: class {
    
    /// Создан список
    func listDetailTableViewController(_ listDetailTableViewController: ListDetailTableViewController, didCreate list: List)
    /// Изменен список
    func listDetailTableViewController(_ listDetailTableViewController: ListDetailTableViewController, didEdit list: List)
    /// Отмена
    func listDetailTableViewControllerCancel(_ listDetailTableViewController: ListDetailTableViewController)
    
}
