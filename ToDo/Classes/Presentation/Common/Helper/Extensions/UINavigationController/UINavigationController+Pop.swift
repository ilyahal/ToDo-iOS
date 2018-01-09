//
//  UINavigationController+Pop.swift
//  ToDo
//
//  Created by Илья Халяпин on 09.01.2018.
//  Copyright © 2018 Илья Халяпин. All rights reserved.
//

import UIKit

extension UINavigationController {
    
    /// Вытолкнуть все контроллеры, до контроллера с указанным типом
    func popToViewController(ofType classForCoder: AnyClass, animated: Bool) {
        for controller in self.viewControllers.reversed() {
            if controller.classForCoder == classForCoder {
                popToViewController(controller, animated: animated)
                break
            }
        }
    }
    
    /// Вытолкнуть указанное количество контроллеров
    func popViewControllers(_ count: Int, animated: Bool) {
        let index = max(self.viewControllers.count - (count + 1), 0)
        popToViewController(self.viewControllers[index], animated: animated)
    }
    
}
