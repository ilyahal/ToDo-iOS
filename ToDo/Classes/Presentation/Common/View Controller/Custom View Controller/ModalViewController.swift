//
//  ModalViewController.swift
//  ToDo
//
//  Created by Илья Халяпин on 09.01.2018.
//  Copyright © 2018 Илья Халяпин. All rights reserved.
//

import UIKit

class ModalViewController: UIViewController {
    
    // MARK: - Outlet
    
    @IBOutlet
    private(set) weak var modalView: ModalView!
    
    
    // MARK: - Инициализация
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        initPhase2()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        initPhase2()
    }
    
    /// Инициализация объекта
    private func initPhase2() {
        self.modalPresentationStyle = .overFullScreen
        self.modalPresentationCapturesStatusBarAppearance = true
        
        self.modalTransitionStyle = .crossDissolve
    }
    
}


// MARK: - UIViewController

extension ModalViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.modalView.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        UIView.animate(withDuration: 0.3) {
            self.modalView.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        UIView.animate(withDuration: 0.3) {
            self.modalView.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }
    }
    
}
