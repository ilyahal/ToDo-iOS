//
//  IconsViewControllerDelegate.swift
//  ToDo
//
//  Created by Илья Халяпин on 10.01.2018.
//  Copyright © 2018 Илья Халяпин. All rights reserved.
//

protocol IconsViewControllerDelegate: class {
    
    /// Выбрана иконка
    func iconsViewController(_ iconsViewController: IconsViewController, didSelect icon: Icon)
    /// Отмена
    func iconsViewControllerCancel(_ iconsViewController: IconsViewController)
    
}
