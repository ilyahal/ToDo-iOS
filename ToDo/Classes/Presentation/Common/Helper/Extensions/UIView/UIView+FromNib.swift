//
//  UIView+FromNib.swift
//  ToDo
//
//  Created by Илья Халяпин on 09.01.2018.
//  Copyright © 2018 Илья Халяпин. All rights reserved.
//

import UIKit

extension UIView {
    
    /// Загрузить view из xib
    func fromNib(withName nibName: String? = nil) -> UIView {
        let nibName = nibName ?? String(describing: type(of: self))
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else { fatalError() }
        
        return view
    }
    
}
