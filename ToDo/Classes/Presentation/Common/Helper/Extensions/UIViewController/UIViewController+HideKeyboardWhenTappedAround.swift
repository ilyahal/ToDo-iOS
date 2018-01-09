//
//  UIViewController+HideKeyboardWhenTappedAround.swift
//  ToDo
//
//  Created by Илья Халяпин on 09.01.2018.
//  Copyright © 2018 Илья Халяпин. All rights reserved.
//

import UIKit

extension UIViewController {
    
    /// Скрывать клавиатуру при тапе вне поля ввода
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        
        self.view.addGestureRecognizer(tap)
    }
    
    /// Скрыть клавиатуру
    @objc
    func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
}
