//
//  ImageAssets.swift
//  ToDo
//
//  Created by Илья Халяпин on 09.01.2018.
//  Copyright © 2018 Илья Халяпин. All rights reserved.
//

import UIKit

enum Asset: String {
    
    // MARK: - Изображения -
    
    /// Иконка "Галочка"
    case iconCheckmark = "icon_checkmark"
    
    
    // MARK: - Публичные свойства
    
    /// Изображение
    var image: UIImage {
        return UIImage(asset: self)
    }
    
}


// MARK: - UIImage

extension UIImage {
    
    // MARK: - Инициализация
    
    convenience init!(asset: Asset) {
        self.init(named: asset.rawValue)
    }
    
}
