//
//  HUDFailureView.swift
//  ToDo
//
//  Created by Илья Халяпин on 09.01.2018.
//  Copyright © 2018 Илья Халяпин. All rights reserved.
//

import UIKit

final class HUDFailureView: HUDContentView {
    
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

extension HUDFailureView {
    
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

private extension HUDFailureView {
    
    var shapeLayer: CAShapeLayer? {
        return self.layer as? CAShapeLayer
    }
    
    /// Крестик
    var crossMarkPath: CGPath {
        let path = UIBezierPath()
        path.move(to: self.layer.center)
        path.addLine(to: .zero)
        path.move(to: self.layer.center)
        path.addLine(to: CGPoint(x: self.bounds.width, y: self.bounds.height))
        path.move(to: self.layer.center)
        path.addLine(to: CGPoint(x: 0, y: self.bounds.height))
        path.move(to: self.layer.center)
        path.addLine(to: CGPoint(x: self.bounds.width, y: 0))
        
        return path.cgPath
    }
    
}


// MARK: - UIView

extension HUDFailureView {
    
    override class var layerClass: AnyClass {
        return CAShapeLayer.self
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let checkmarkPath = self.crossMarkPath
        self.shapeLayer?.path = checkmarkPath
    }
    
}


// MARK: - HUDContentView

extension HUDFailureView {
    
    override func startAnimation() {
        self.alpha = 0
        self.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(280)) { [weak self] in
            UIView.animate(withDuration: 0.15) {
                self?.alpha = 1
                self?.transform = CGAffineTransform(scaleX: 1, y: 1)
                
                // Тактильный отклик
                if #available(iOS 10.0, *) {
                    let feedbackGenerator = UINotificationFeedbackGenerator()
                    feedbackGenerator.notificationOccurred(.error)
                }
            }
        }
    }
    
    override func stopAnimation() { }
    
}


// MARK: - Приватные методы

extension HUDFailureView {
    
    /// Настроить
    func setup() {
        self.shapeLayer?.fillMode = kCAFillModeForwards
        self.shapeLayer?.lineCap = kCALineCapRound
        self.shapeLayer?.lineJoin = kCALineJoinRound
        self.shapeLayer?.fillColor = nil
        self.shapeLayer?.lineWidth = 3
    }
    
}
