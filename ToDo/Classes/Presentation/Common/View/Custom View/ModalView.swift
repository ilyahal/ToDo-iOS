//
//  ModalView.swift
//  ToDo
//
//  Created by Илья Халяпин on 09.01.2018.
//  Copyright © 2018 Илья Халяпин. All rights reserved.
//

import UIKit

@IBDesignable
final class ModalView: UIView {
    
    // MARK: - Инициализация
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        initPhase2()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        initPhase2()
    }
    
    /// Инициализация объекта
    private func initPhase2() {
        self.cornerRadius = 5
    }
    
}


// MARK: - Публичные свойства

extension ModalView {
    
    /// Радиус скругления
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
        }
    }
    
}


// MARK: - UIView

extension ModalView {
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        
        runtimeSetup()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        runtimeSetup()
    }
    
}


// MARK: - Приватные методы

private extension ModalView {
    
    /// Настройка при выполнении
    func runtimeSetup() {
        self.superview?.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0.2274509804, alpha: 0.3967893836)
    }
    
}
