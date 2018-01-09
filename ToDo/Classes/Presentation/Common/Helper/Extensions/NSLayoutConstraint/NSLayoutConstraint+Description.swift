//
//  NSLayoutConstraint+Description.swift
//  ToDo
//
//  Created by Илья Халяпин on 09.01.2018.
//  Copyright © 2018 Илья Халяпин. All rights reserved.
//

import UIKit

extension NSLayoutConstraint {
    
    /// Вывод идентификатора ограничения, с которым возникла проблема
    override open var description: String {
        let id = self.identifier ?? .empty
        return "id: \(id), constant: \(self.constant)"
    }
    
}
