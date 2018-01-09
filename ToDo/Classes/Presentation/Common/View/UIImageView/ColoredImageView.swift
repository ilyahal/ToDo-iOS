//
//  ColoredImageView.swift
//  ToDo
//
//  Created by Илья Халяпин on 09.01.2018.
//  Copyright © 2018 Илья Халяпин. All rights reserved.
//

import UIKit

@IBDesignable
final class ColoredImageView: UIImageView {
    
    // MARK: - Публичные свойства
    
    /// Цвет изображения
    @IBInspectable
    var maskColor: UIColor? {
        willSet {
            guard let color = newValue else { return }
            self.image = self.image?.mask(with: color)
        }
    }
    
}
