//
//  ItemTableViewCellDelegate.swift
//  ToDo
//
//  Created by Илья Халяпин on 11.01.2018.
//  Copyright © 2018 Илья Халяпин. All rights reserved.
//

protocol ItemTableViewCellDelegate: class {
    
    /// Нажата галочка
    func itemTableViewCell(_ itemTableViewCell: ItemTableViewCell, willChange item: Item)
    
}
