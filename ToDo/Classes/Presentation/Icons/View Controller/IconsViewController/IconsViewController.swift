//
//  IconsViewController.swift
//  ToDo
//
//  Created by Илья Халяпин on 10.01.2018.
//  Copyright © 2018 Илья Халяпин. All rights reserved.
//

import UIKit

final class IconsViewController: UIViewController {
    
    // MARK: - Outlet
    
    @IBOutlet
    private weak var tableView: UITableView! {
        willSet {
            newValue.dataSource = self
            newValue.delegate = self
        }
    }
    
    
    // MARK: - Публичные свойства
    
    weak var delegate: IconsViewControllerDelegate?
    
    /// Иконки
    var icons: [Icon] = []
    /// Активная иконка
    var active: Icon!
    
}


// MARK: - UIViewController

extension IconsViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let index = self.icons.index(where: { $0.iconId == active.iconId }) {
            let indexPath = IndexPath(row: index, section: 0)
            self.tableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
        }
    }
    
}


// MARK: - Action

private extension IconsViewController {
    
    /// Нажата кнопка "Отмена"
    @IBAction
    func cancelButtonTapped() {
        self.delegate?.iconsViewControllerCancel(self)
    }
    
    /// Нажата кнопка "Готово"
    @IBAction
    func doneButtonTapped() {
        self.delegate?.iconsViewController(self, didSelect: self.active)
    }
    
}


// MARK: - UITableViewDataSource

extension IconsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.icons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let icon = self.icons[indexPath.row]
        let isActive = self.active == icon
        let cell = tableView.dequeueReusableCell(withIdentifier: IconTableViewCell.cellIdentifier, for: indexPath) as! IconTableViewCell
        cell.configure(for: icon, active: isActive)
        
        return cell
    }
    
}


// MARK: - UITableViewDelegate

extension IconsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let tmpIndex = self.icons.index(where: { $0.iconId == self.active.iconId}), tmpIndex != indexPath.row {
            self.active = self.icons[indexPath.row]
            
            let tmpIndexPath = IndexPath(row: tmpIndex, section: 0)
            
            tableView.beginUpdates()
            tableView.reloadRows(at: [indexPath, tmpIndexPath], with: .none)
            tableView.endUpdates()
        }
    }
    
}
