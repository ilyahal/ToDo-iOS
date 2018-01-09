//
//  UITableViewCell+CellIdentifiable.swift
//  ToDo
//
//  Created by Илья Халяпин on 09.01.2018.
//  Copyright © 2018 Илья Халяпин. All rights reserved.
//

import UIKit

extension UITableViewCell: CellIdentifiable {
    
    static var cellIdentifier: String {
        return String(describing: self)
    }
    
}
