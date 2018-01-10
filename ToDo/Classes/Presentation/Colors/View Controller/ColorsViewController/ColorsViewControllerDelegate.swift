//
//  ColorsViewControllerDelegate.swift
//  ToDo
//
//  Created by Илья Халяпин on 10.01.2018.
//  Copyright © 2018 Илья Халяпин. All rights reserved.
//

protocol ColorsViewControllerDelegate: class {
    
    /// Выбран цвет
    func colorsViewController(_ colorsViewController: ColorsViewController, didSelect color: Color)
    /// Отмена
    func colorsViewControllerCancel(_ colorsViewController: ColorsViewController)
    
}
