//
//  HUDSuccessView.swift
//  ToDo
//
//  Created by Илья Халяпин on 09.01.2018.
//  Copyright © 2018 Илья Халяпин. All rights reserved.
//

import UIKit

final class HUDSuccessView: HUDContentView {
    
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
        setup()
    }
    
}


// MARK: - Публичные свойства

extension HUDSuccessView {
    
    /// Цвет
    var color: UIColor? {
        get {
            guard let color = self.shapeLayer?.strokeColor else { return nil }
            return UIColor(cgColor: color)
        }
        set {
            self.shapeLayer?.strokeColor = newValue?.cgColor
        }
    }
    
}


// MARK: - Приватные свойства

private extension HUDSuccessView {
    
    var shapeLayer: CAShapeLayer? {
        return self.layer as? CAShapeLayer
    }
    
    /// Галочка
    var checkmarkPath: CGPath {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: self.bounds.height * 0.4))
        path.addLine(to: CGPoint(x: self.bounds.width * 0.4, y: self.bounds.height))
        path.addLine(to: CGPoint(x: self.bounds.width, y: 0))
        
        return path.cgPath
    }
    
}


// MARK: - UIView

extension HUDSuccessView {
    
    override class var layerClass: AnyClass {
        return CAShapeLayer.self
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let checkmarkPath = self.checkmarkPath
        self.shapeLayer?.path = checkmarkPath
    }
    
}


// MARK: - HUDContentView

extension HUDSuccessView {
    
    override func startAnimation() {
        self.shapeLayer?.opacity = 0
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(280)) { [weak self] in
            self?.shapeLayer?.opacity = 1
            
            let animation = CABasicAnimation(keyPath: "strokeEnd")
            animation.fromValue = 0
            animation.duration = 0.2
            
            self?.shapeLayer?.add(animation, forKey: "checkmarkAnimation")
            
            // Тактильный отклик
            if #available(iOS 10.0, *) {
                let feedbackGenerator = UINotificationFeedbackGenerator()
                feedbackGenerator.notificationOccurred(.success)
            }
        }
    }
    
    override func stopAnimation() {
        self.shapeLayer?.removeAnimation(forKey: "checkmarkAnimation")
    }
    
}


// MARK: - Приватные методы

extension HUDSuccessView {
    
    /// Настроить
    func setup() {
        self.shapeLayer?.fillMode = kCAFillModeForwards
        self.shapeLayer?.lineCap = kCALineCapRound
        self.shapeLayer?.lineJoin = kCALineJoinRound
        self.shapeLayer?.fillColor = nil
        self.shapeLayer?.lineWidth = 3
    }
    
}
