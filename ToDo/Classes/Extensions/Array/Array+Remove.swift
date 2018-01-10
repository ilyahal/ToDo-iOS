//
//  Array+Remove.swift
//  ToDo
//
//  Created by Илья Халяпин on 10.01.2018.
//  Copyright © 2018 Илья Халяпин. All rights reserved.
//

extension Array where Element: Equatable {
    
    /// Удалить первый элемент массива, который эквивалентен передаваемому объекту
    mutating func remove(object: Element) {
        if let index = index(of: object) {
            remove(at: index)
        }
    }
    
}
