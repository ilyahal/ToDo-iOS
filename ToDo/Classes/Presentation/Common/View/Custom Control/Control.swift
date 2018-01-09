//
//  Control.swift
//  ToDo
//
//  Created by Илья Халяпин on 09.01.2018.
//  Copyright © 2018 Илья Халяпин. All rights reserved.
//

import UIKit

class Control: UIControl { }


// MARK: - UIControl

extension Control {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        animate(isPressed: true)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        
        animate(isPressed: false)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        animate(isPressed: false)
    }
    
}


// MARK: - Приватные методы

private extension Control {
    
    /// Анимировать состояние
    func animate(isPressed: Bool) {
        let (duration, alpha): (Double, CGFloat) = {
            isPressed
                ? (duration: 0.05, alpha: 0.7)
                : (duration: 0.1, alpha: 1)
        }()
        
        UIView.animate(withDuration: duration) {
            self.alpha = alpha
        }
    }
    
}
