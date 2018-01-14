//
//  IconTableViewCell.swift
//  ToDo
//
//  Created by Илья Халяпин on 10.01.2018.
//  Copyright © 2018 Илья Халяпин. All rights reserved.
//

import UIKit

final class IconTableViewCell: UITableViewCell {
    
    // MARK: - Outlet
    
    /// Иконка
    @IBOutlet
    private weak var iconImageView: UIImageView!
    
}


// MARK: - Публичные методы

extension IconTableViewCell {
    
    /// Настройка
    func configure(for icon: Icon, active: Bool) {
        let icon = UIImage(named: "api_\(icon.name)")
        self.iconImageView.image = icon
        
        self.accessoryType = active ? .checkmark : .none
    }
    
}
