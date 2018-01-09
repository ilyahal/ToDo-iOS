//
//  RoundedTextField.swift
//  ToDo
//
//  Created by Илья Халяпин on 10.01.2018.
//  Copyright © 2018 Илья Халяпин. All rights reserved.
//

import UIKit

@IBDesignable
final class RoundedTextField: UITextField { }


// MARK: - UIView

extension RoundedTextField {
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        
        runtimeSetup()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        runtimeSetup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.masksToBounds = true
        self.layer.cornerRadius = self.frame.height / 2
    }
    
}


// MARK: - Приватные методы

private extension RoundedTextField {
    
    /// Настройка при выполнении
    func runtimeSetup() {
        self.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.9607843137, blue: 0.968627451, alpha: 1)
        self.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        let font: UIFont = .systemFont(ofSize: 18)
        
        self.font = font
        self.textAlignment = .center
        self.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        let centeredParagraphStyle = NSMutableParagraphStyle()
        centeredParagraphStyle.alignment = .center
        
        let placeholderTextAttributes: [NSAttributedStringKey : Any] = [
            .paragraphStyle: centeredParagraphStyle,
            .font: font,
            .foregroundColor: #colorLiteral(red: 0, green: 0, blue: 0.0980392, alpha: 0.22)
        ]
        let attributedPlaceholder = NSAttributedString(string: self.placeholder ?? .empty, attributes: placeholderTextAttributes)
        self.attributedPlaceholder = attributedPlaceholder
    }
    
}
