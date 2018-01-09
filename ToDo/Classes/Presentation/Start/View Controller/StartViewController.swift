//
//  StartViewController.swift
//  ToDo
//
//  Created by Илья Халяпин on 09.01.2018.
//  Copyright © 2018 Илья Халяпин. All rights reserved.
//

import UIKit

final class StartViewController: UIViewController {
    
    // MARK: - Приватные свойства
    
    private lazy var router: StartRouter = StartRouter(presenter: self)
    
    /// Сервис настроек приложения
    private let applicationSettingsService = ServiceLayer.instance.applicationSettingsService
    
}


// MARK: - UIViewController

extension StartViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if self.applicationSettingsService.isLogined {
            self.router.makeRootLists()
        } else {
            self.router.makeRootRegistration()
        }
    }
    
}
