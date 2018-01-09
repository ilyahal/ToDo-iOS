//
//  CALayer+Center.swift
//  ToDo
//
//  Created by Илья Халяпин on 09.01.2018.
//  Copyright © 2018 Илья Халяпин. All rights reserved.
//

import QuartzCore

extension CALayer {
    
    /// Центр слоя
    var center: CGPoint {
        return CGPoint(x: self.bounds.width / 2, y: self.bounds.height / 2)
    }
    
}
