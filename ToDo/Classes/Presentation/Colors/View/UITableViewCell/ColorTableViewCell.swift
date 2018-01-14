//
//  ColorTableViewCell.swift
//  ToDo
//
//  Created by Илья Халяпин on 10.01.2018.
//  Copyright © 2018 Илья Халяпин. All rights reserved.
//

import UIKit

final class ColorTableViewCell: UITableViewCell {
    
    // MARK: - Outlet
    
    /// Задний фон
    @IBOutlet
    private weak var backgroundImageView: UIImageView!
    /// Правый отступ
    @IBOutlet
    private weak var backgroundImageViewTrailingLayoutConstraint: NSLayoutConstraint!
    
}


// MARK: - Публичные методы

extension ColorTableViewCell {
    
    /// Настройка
    func configure(for color: Color, active: Bool) {
        let color = UIColor(red: CGFloat(color.red) / 255.0, green: CGFloat(color.green) / 255.0, blue: CGFloat(color.blue) / 255.0, alpha: 1)
        self.backgroundImageView.image = .generate(with: color)
        
        self.accessoryType = active ? .checkmark : .none
        self.backgroundImageViewTrailingLayoutConstraint.constant = active ? 5 : 0
    }
    
}
