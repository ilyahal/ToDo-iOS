//
//  CheckboxButton.swift
//  ToDo
//
//  Created by Илья Халяпин on 11.01.2018.
//  Copyright © 2018 Илья Халяпин. All rights reserved.
//

import UIKit

@IBDesignable
final class CheckboxButton: UIButton {
    
    // MARK: - Публичные свойства
    
    /// Цвет фона активной кнопки
    @IBInspectable
    var activeBackgroundColor: UIColor? {
        willSet {
            if self.isActive {
                self.shapeLayer?.fillColor = newValue?.cgColor
            }
            
            self.shapeLayer?.strokeColor = newValue?.cgColor
        }
    }
    /// Цвет фона неактивной кнопки
    @IBInspectable
    var inactiveBackgroundColor: UIColor? {
        willSet {
            if !self.isActive {
                self.shapeLayer?.fillColor = newValue?.cgColor
            }
        }
    }
    
    /// Активна кнопка
    private(set) var isActive = false
    
    
    // MARK: - Приватные свойства
    
    /// Слой с галочкой
    let checkmarkShapeLayer = CAShapeLayer()
    
    
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
        self.shapeLayer?.lineWidth = 1
        
        self.activeBackgroundColor = self.tintColor
        self.inactiveBackgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.checkmarkColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        setActive(true, animated: false)
        
        self.checkmarkShapeLayer.frame = CGRect(origin: .zero, size: CGSize(width: 10, height: 7))
        self.checkmarkShapeLayer.fillColor = nil
        self.checkmarkShapeLayer.lineCap = kCALineCapRound
        self.checkmarkShapeLayer.lineJoin = kCALineJoinRound
        self.checkmarkShapeLayer.lineWidth = 2
        
        let checkmarkPath = CGMutablePath()
        checkmarkPath.move(to: CGPoint(x: 0, y: 3))
        checkmarkPath.addLine(to: CGPoint(x: 4, y: self.checkmarkShapeLayer.frame.height))
        checkmarkPath.addLine(to: CGPoint(x: self.checkmarkShapeLayer.frame.width, y: 0))
        self.checkmarkShapeLayer.path = checkmarkPath
        
        self.layer.addSublayer(self.checkmarkShapeLayer)
    }
    
}


// MARK: - Публичные свойства

extension CheckboxButton {
    
    /// Цвет галочки
    @IBInspectable
    var checkmarkColor: UIColor? {
        get {
            guard let color = self.checkmarkShapeLayer.strokeColor else { return nil }
            return UIColor(cgColor: color)
        }
        set {
            self.checkmarkShapeLayer.strokeColor = newValue?.cgColor
        }
    }
    
}


// MARK: - Приватные свойства

private extension CheckboxButton {
    
    var shapeLayer: CAShapeLayer? {
        return self.layer as? CAShapeLayer
    }
    
}


// MARK: - UIControl

extension CheckboxButton {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        animate(isPressed: true)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        
        animate(isPressed: false)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        animate(isPressed: false)
    }
    
}


// MARK: - UIView

extension CheckboxButton {
    
    override class var layerClass: AnyClass {
        return CAShapeLayer.self
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let path = UIBezierPath(roundedRect: self.bounds, cornerRadius: 5)
        self.shapeLayer?.path = path.cgPath
        
        self.checkmarkShapeLayer.position = self.layer.center
    }
    
}


// MARK: - Публичные методы

extension CheckboxButton {
    
    /// Присвоить состояние
    func setActive(_ active: Bool, animated: Bool) {
        guard self.isActive != active else { return }
        self.isActive = active
        
        if animated {
            let firstAnimationKey = "fillColor"
            let secondAnimationKey = "opacity"
            let (duration, firstFromValue, firstToValue, secondFromValue, secondToValue): (Double, CGColor?, CGColor?, Float, Float) = {
                active
                    ? (duration: 0.05, firstFromValue: self.inactiveBackgroundColor?.cgColor, firstToValue: self.activeBackgroundColor?.cgColor, secondFromValue: 0, secondToValue: 1)
                    : (duration: 0.1, firstFromValue: self.activeBackgroundColor?.cgColor, firstToValue: self.inactiveBackgroundColor?.cgColor, secondFromValue: 1, secondToValue: 0)
            }()
            
            let firstAnimation = CABasicAnimation()
            firstAnimation.duration = duration
            firstAnimation.fromValue = firstFromValue
            firstAnimation.toValue = firstToValue
            self.shapeLayer?.fillColor = firstToValue
            self.shapeLayer?.removeAnimation(forKey: firstAnimationKey)
            self.shapeLayer?.add(firstAnimation, forKey: firstAnimationKey)
            
            let secondAnimation = CABasicAnimation()
            secondAnimation.duration = duration
            secondAnimation.fromValue = secondFromValue
            secondAnimation.toValue = secondToValue
            self.checkmarkShapeLayer.opacity = secondToValue
            self.checkmarkShapeLayer.removeAnimation(forKey: secondAnimationKey)
            self.checkmarkShapeLayer.add(secondAnimation, forKey: secondAnimationKey)
        } else {
            self.shapeLayer?.fillColor = active ? self.activeBackgroundColor?.cgColor : self.inactiveBackgroundColor?.cgColor
            self.checkmarkShapeLayer.opacity = active ? 1 : 0
        }
    }
    
}


// MARK: - Приватные методы

private extension CheckboxButton {
    
    /// Анимировать состояние
    func animate(isPressed: Bool) {
        let (duration, alpha): (Double, CGFloat) = {
            isPressed
                ? (duration: 0.05, alpha: 0.7)
                : (duration: 0.1, alpha: 1)
        }()
        
        UIView.animate(withDuration: duration) {
            self.alpha = alpha
        }
    }
    
}
