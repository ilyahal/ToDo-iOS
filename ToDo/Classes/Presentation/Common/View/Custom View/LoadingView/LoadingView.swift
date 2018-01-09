//
//  LoadingView.swift
//  ToDo
//
//  Created by Илья Халяпин on 09.01.2018.
//  Copyright © 2018 Илья Халяпин. All rights reserved.
//

import UIKit

final class LoadingView: UIView {
    
    // MARK: - Outlet
    
    /// Индикатор активности
    @IBOutlet
    private weak var activityIndicatorView: UIActivityIndicatorView!
    /// Надпись
    @IBOutlet
    private weak var titleLabel: UILabel!
    
    
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
        setupRootView()
        
        self.activityIndicatorView.startAnimating()
    }
    
}


// MARK: - Публичные свойства

extension LoadingView {
    
    /// Цвет индикатора активности
    var activityIndicatorColor: UIColor? {
        get {
            return self.activityIndicatorView.color
        }
        set {
            self.activityIndicatorView.color = newValue
        }
    }
    
    /// Шрифт надписи
    var font: UIFont {
        get {
            return self.titleLabel.font
        }
        set {
            self.titleLabel.font = newValue
        }
    }
    
    /// Текст надписи
    var textColor: UIColor {
        get {
            return self.titleLabel.textColor
        }
        set {
            self.titleLabel.textColor = newValue
        }
    }
    
}


// MARK: - Приватные методы

private extension LoadingView {
    
    /// Подготовка корневого view
    func setupRootView() {
        let view = fromNib()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(view)
        view.layoutAttachAll(to: self)
    }
    
}
