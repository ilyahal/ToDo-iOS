//
//  CGSize+Initialization.swift
//  ToDo
//
//  Created by Илья Халяпин on 09.01.2018.
//  Copyright © 2018 Илья Халяпин. All rights reserved.
//

import CoreGraphics

extension CGSize {
    
    /// Равные ширина и высота
    init(square length: CGFloat) {
        self.init(width: length, height: length)
    }
    
}
