//
//  UIWindow+TransitToViewController.swift
//  ToDo
//
//  Created by Илья Халяпин on 09.01.2018.
//  Copyright © 2018 Илья Халяпин. All rights reserved.
//

import UIKit

extension UIWindow {
    
    // MARK: - Публичные методы типа
    
    /// Выполнить переход к view controller и сделать его основным
    class func keyWindowTransit(to viewController: UIViewController) {
        UIApplication.shared.keyWindow?.transit(to: viewController)
    }
    
    
    // MARK - Приватные методы
    
    /// Выполнить переход к view controller и сделать его основным
    private func transit(to viewController: UIViewController) {
        let currentSubviews = self.subviews
        
        guard let rootViewController = self.rootViewController else { return }
        insertSubview(viewController.view, belowSubview: rootViewController.view)
        
        UIView.transition(with: self, duration: 0.4, options: .transitionCrossDissolve, animations: {
            self.rootViewController = viewController
        }) { _ in
            currentSubviews.forEach { $0.removeFromSuperview() }
        }
    }
    
}
