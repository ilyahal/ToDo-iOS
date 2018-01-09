//
//  HUDLoadingView.swift
//  ToDo
//
//  Created by Илья Халяпин on 09.01.2018.
//  Copyright © 2018 Илья Халяпин. All rights reserved.
//

import UIKit

final class HUDLoadingView: HUDContentView {
    
    // MARK: - Приватные свойства
    
    /// Индикатор активности
    private weak var activityIndicatorView: UIActivityIndicatorView!
    
    
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

extension HUDLoadingView {
    
    /// Цвет
    var color: UIColor? {
        get {
            return self.activityIndicatorView.color
        }
        set {
            self.activityIndicatorView.color = newValue
        }
    }
    
}


// MARK: - HUDContentView

extension HUDLoadingView {
    
    override func startAnimation() {
        self.activityIndicatorView.startAnimating()
    }
    
    override func stopAnimation() {
        self.activityIndicatorView.stopAnimating()
    }
    
}


// MARK: - Приватные методы

private extension HUDLoadingView {
    
    /// Настроить
    func setup() {
        let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        self.activityIndicatorView = activityIndicatorView
        
        addSubview(activityIndicatorView)
        activityIndicatorView.layoutAttachAll(to: self)
    }
    
}
