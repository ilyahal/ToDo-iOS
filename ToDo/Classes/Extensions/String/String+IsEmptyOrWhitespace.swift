//
//  String+IsEmptyOrWhitespace.swift
//  ToDo
//
//  Created by Илья Халяпин on 09.01.2018.
//  Copyright © 2018 Илья Халяпин. All rights reserved.
//

extension String {
    
    /// Является строка пустой
    var isEmptyOrWhitespace: Bool {
        return trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
}
