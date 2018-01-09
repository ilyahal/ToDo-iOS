//
//  UIView+LayoutAttachAll.swift
//  ToDo
//
//  Created by Илья Халяпин on 09.01.2018.
//  Copyright © 2018 Илья Халяпин. All rights reserved.
//

import UIKit

extension UIView {
    
    /// Прикрепить границы ко view
    func layoutAttachAll(to view: UIView) {
        let constraints = [
            self.topAnchor.constraint(equalTo: view.topAnchor),
            self.rightAnchor.constraint(equalTo: view.rightAnchor),
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            self.leftAnchor.constraint(equalTo: view.leftAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
}
