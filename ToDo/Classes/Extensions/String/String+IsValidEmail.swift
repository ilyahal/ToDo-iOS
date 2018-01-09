//
//  String+IsValidEmail.swift
//  ToDo
//
//  Created by Илья Халяпин on 09.01.2018.
//  Copyright © 2018 Илья Халяпин. All rights reserved.
//

import Foundation

extension String {
    
    /// Является строка валидным email
    var isValidEmail: Bool {
        // let emailRegEx = "[0-9A-Za-z._%+-]+@[0-9A-Za-z.-]+\\.[A-Za-z]{2,6}"
        let emailRegEx = ".+@.+\\..+" // .(любой символ кроме конца строки)+(1 или больше)@.+\\.(наличие точки).+
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: self)
        
        return result
    }
    
}
