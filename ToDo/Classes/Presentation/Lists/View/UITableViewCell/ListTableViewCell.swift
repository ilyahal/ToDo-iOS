//
//  ListTableViewCell.swift
//  ToDo
//
//  Created by Илья Халяпин on 10.01.2018.
//  Copyright © 2018 Илья Халяпин. All rights reserved.
//

import UIKit

final class ListTableViewCell: UITableViewCell {
    
    // MARK: - Outlet
    
    /// Иконка
    @IBOutlet
    private weak var iconImageView: UIImageView!
    /// Название
    @IBOutlet
    private weak var titleLabel: UILabel!
    /// Описание
    @IBOutlet
    private weak var descriptionLabel: UILabel!
    
}


// MARK: - Публичные методы

extension ListTableViewCell {
    
    /// Настройка
    func configure(for list: List, with icon: Icon?, and color: Color?) {
        if let icon = icon {
            var image = UIImage(named: "api_\(icon.name)")
            
            if let color = color {
                let red = CGFloat(color.red) / 255.0
                let green = CGFloat(color.green) / 255.0
                let blue = CGFloat(color.blue) / 255.0
                let iconColor = UIColor(red: red, green: green, blue: blue, alpha: 1)
                
                image = image?.mask(with: iconColor)
            }
            
            self.iconImageView.image = image
        } else {
            self.iconImageView.image = nil
        }
            
        self.titleLabel.text = list.title
        
        self.descriptionLabel.isHidden = list.description?.isEmpty ?? true
        self.descriptionLabel.text = list.description
    }
    
}
