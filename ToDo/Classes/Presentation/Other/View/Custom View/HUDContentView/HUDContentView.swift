//
//  HUDContentView.swift
//  ToDo
//
//  Created by Илья Халяпин on 09.01.2018.
//  Copyright © 2018 Илья Халяпин. All rights reserved.
//

import UIKit

class HUDContentView: UIView { }


// MARK: - Публичные методы

extension HUDContentView {
    
    /// Начать анимацию
    @objc
    func startAnimation() {
        fatalError("Must be overriden")
    }
    
    /// Остановить анимацию
    @objc
    func stopAnimation() {
        fatalError("Must be overriden")
    }
    
}
