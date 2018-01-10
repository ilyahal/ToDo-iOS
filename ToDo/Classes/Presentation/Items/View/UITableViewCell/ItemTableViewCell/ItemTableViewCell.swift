//
//  ItemTableViewCell.swift
//  ToDo
//
//  Created by Илья Халяпин on 10.01.2018.
//  Copyright © 2018 Илья Халяпин. All rights reserved.
//

import UIKit

final class ItemTableViewCell: UITableViewCell {
    
    // MARK: - Outlet
    
    /// Галочка
    @IBOutlet
    private weak var checkmarkButton: CheckboxButton!
    /// Название
    @IBOutlet
    private weak var titleLabel: UILabel!
    /// Описание
    @IBOutlet
    private weak var descriptionLabel: UILabel!
    
    
    // MARK: - Публичные свойства
    
    weak var delegate: ItemTableViewCellDelegate?
    
    /// Запись
    var item: Item!
    
}


// MARK: - Action

private extension ItemTableViewCell {
    
    /// Нажата галочка
    @IBAction
    func checkmarkButtonTapped() {
        self.delegate?.itemTableViewCell(self, willChange: self.item)
        
        // Тактильный отклик
        if #available(iOS 10.0, *) {
            let feedbackGenerator = UIImpactFeedbackGenerator(style: .light)
            feedbackGenerator.impactOccurred()
        }
    }
    
}


// MARK: - Публичные методы

extension ItemTableViewCell {
    
    func configure(for item: Item) {
        self.item = item
        
        self.checkmarkButton.setActive(item.isActive, animated: false)
        self.titleLabel.text = item.title
        
        self.descriptionLabel.isHidden = item.description?.isEmpty ?? true
        self.descriptionLabel.text = item.description
    }
    
    func updateActive() {
        self.checkmarkButton.setActive(item.isActive, animated: true)
    }
    
}
