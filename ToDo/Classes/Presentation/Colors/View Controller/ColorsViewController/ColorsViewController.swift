//
//  ColorsViewController.swift
//  ToDo
//
//  Created by Илья Халяпин on 10.01.2018.
//  Copyright © 2018 Илья Халяпин. All rights reserved.
//

import UIKit

final class ColorsViewController: UIViewController {
    
    // MARK: - Outlet
    
    @IBOutlet
    private weak var tableView: UITableView! {
        willSet {
            newValue.dataSource = self
            newValue.delegate = self
        }
    }
    
    
    // MARK: - Публичные свойства
    
    weak var delegate: ColorsViewControllerDelegate?
    
    /// Цвета
    var colors: [Color] = []
    /// Активный цвет
    var active: Color!
    
}


// MARK: - UIViewController

extension ColorsViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let index = self.colors.index(where: { $0.colorId == active.colorId }) {
            let indexPath = IndexPath(row: index, section: 0)
            self.tableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
        }
    }
    
}


// MARK: - Action

private extension ColorsViewController {
    
    /// Нажата кнопка "Отмена"
    @IBAction
    func cancelButtonTapped() {
        self.delegate?.colorsViewControllerCancel(self)
    }
    
    /// Нажата кнопка "Готово"
    @IBAction
    func doneButtonTapped() {
        self.delegate?.colorsViewController(self, didSelect: self.active)
    }
    
}


// MARK: - UITableViewDataSource

extension ColorsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.colors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let color = self.colors[indexPath.row]
        let isActive = self.active == color
        let cell = tableView.dequeueReusableCell(withIdentifier: ColorTableViewCell.cellIdentifier, for: indexPath) as! ColorTableViewCell
        cell.configure(for: color, active: isActive)
        
        return cell
    }
    
}


// MARK: - UITableViewDelegate

extension ColorsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let tmpIndex = self.colors.index(where: { $0.colorId == self.active.colorId}), tmpIndex != indexPath.row {
            self.active = self.colors[indexPath.row]
            
            let tmpIndexPath = IndexPath(row: tmpIndex, section: 0)
            
            tableView.beginUpdates()
            tableView.reloadRows(at: [indexPath, tmpIndexPath], with: .none)
            tableView.endUpdates()
        }
    }
    
}
