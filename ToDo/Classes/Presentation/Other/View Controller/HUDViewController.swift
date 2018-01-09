//
//  HUDViewController.swift
//  ToDo
//
//  Created by Илья Халяпин on 09.01.2018.
//  Copyright © 2018 Илья Халяпин. All rights reserved.
//

import UIKit

final class HUDViewController: ModalViewController {
    
    // MARK: - Публичные свойства
    
    /// Тип отображаемого контента
    var contentType: HUDContentType! {
        didSet {
            setupContent()
        }
    }
    
    
    // MARK: - Приватные свойства
    
    /// Отображаемый контент
    private weak var contentView: HUDContentView?
    
}


// MARK: - UIViewController

extension HUDViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupContent()
    }
    
}


// MARK: - Приватные методы

private extension HUDViewController {
    
    /// Настроить отображаемый контент
    func setupContent() {
        guard self.isViewLoaded else { return }
        
        // Скрываем текущий контент
        hideContent()
        
        // Отображаем новый контент
        guard let contentType = self.contentType else { return }
        
        switch contentType {
        case .loading:
            self.contentView = setupLoading()
        case .success:
            self.contentView = setupSuccess()
        case .failure:
            self.contentView = setupFailure()
        }
        
        self.contentView?.startAnimation()
    }
    
    /// Скрыть контент
    func hideContent() {
        guard let contentView = self.contentView else { return }
        self.contentView = nil
        
        UIView.animate(withDuration: 0.2, animations: {
            contentView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            contentView.alpha = 0
        }) { _ in
            contentView.stopAnimation()
            contentView.removeFromSuperview()
        }
    }
    
    /// Настроить отображение загрузки
    func setupLoading() -> HUDContentView {
        let loadingView = HUDLoadingView(frame: .zero)
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        loadingView.color = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        self.modalView.addSubview(loadingView)
        
        let constraints = [
            loadingView.centerXAnchor.constraint(equalTo: self.modalView.centerXAnchor),
            loadingView.centerYAnchor.constraint(equalTo: self.modalView.centerYAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
        
        return loadingView
    }
    
    /// Настроить отображение успеха
    func setupSuccess() -> HUDContentView {
        let successView = HUDSuccessView(frame: .zero)
        successView.translatesAutoresizingMaskIntoConstraints = false
        successView.color = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        self.modalView.addSubview(successView)
        
        let constraints = [
            successView.widthAnchor.constraint(equalToConstant: 40),
            successView.heightAnchor.constraint(equalToConstant: 25),
            successView.centerXAnchor.constraint(equalTo: self.modalView.centerXAnchor),
            successView.centerYAnchor.constraint(equalTo: self.modalView.centerYAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
        
        return successView
    }
    
    /// Настроить отображение неудачи
    func setupFailure() -> HUDContentView {
        let failureView = HUDFailureView(frame: .zero)
        failureView.translatesAutoresizingMaskIntoConstraints = false
        failureView.color = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        self.modalView.addSubview(failureView)
        
        let constraints = [
            failureView.widthAnchor.constraint(equalToConstant: 35),
            failureView.heightAnchor.constraint(equalToConstant: 35),
            failureView.centerXAnchor.constraint(equalTo: self.modalView.centerXAnchor),
            failureView.centerYAnchor.constraint(equalTo: self.modalView.centerYAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
        
        return failureView
    }
    
}
