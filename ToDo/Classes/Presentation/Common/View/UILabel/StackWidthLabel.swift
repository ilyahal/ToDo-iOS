//
//  StackWidthLabel.swift
//  ToDo
//
//  Created by Илья Халяпин on 09.01.2018.
//  Copyright © 2018 Илья Халяпин. All rights reserved.
//

import UIKit

@IBDesignable
final class StackWidthLabel: UILabel { }


// MARK: - UIView

extension {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.preferredMaxLayoutWidth = self.bounds.width
    }
    
}
