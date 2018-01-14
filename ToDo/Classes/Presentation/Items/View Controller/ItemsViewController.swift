//
//  ItemsViewController.swift
//  ToDo
//
//  Created by Илья Халяпин on 10.01.2018.
//  Copyright © 2018 Илья Халяпин. All rights reserved.
//

import UIKit
import Alamofire
import DZNEmptyDataSet

final class ItemsViewController: UIViewController {
    
    // MARK: - Outlet
    
    @IBOutlet
    private weak var tableView: UITableView! {
        willSet {
            newValue.dataSource = self
            newValue.delegate = self
        }
    }
    
    
    // MARK: - Публичные свойства
    
    var list: List!
    
    
    // MARK: - Приватные свойства
    
    private lazy var router: ItemsRouter = ItemsRouter(presenter: self)
    
    /// Сервис API
    private let apiService = ServiceLayer.instance.apiService
    
    /// Записи
    private var items: [Item] = []
    
    /// Активный запрос
    private weak var activeRequest: Request?
    /// Состояние
    private var status: LoadingStatus = .unknown
    /// Доступность обновления
    private var isUpdateAvailable = true
    
    
    // MARK: - Деинициализация
    
    deinit {
        
        // Отменяем запрос
        cancelLoad()
    }
    
}


// MARK: - UIViewController

extension ItemsViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        loadData()
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
        self.tableView.setEditing(editing, animated: animated)
        
        self.tableView.beginUpdates()
        
        let insertRowIndexPath = IndexPath(row: 0, section: 0)
        if editing {
            if self.status == .load {
                cancelLoad()
            }
            
            self.tableView.insertRows(at: [insertRowIndexPath], with: .automatic)
        } else {
            if self.status == .unknown {
                loadData()
            }
            
            self.tableView.deleteRows(at: [insertRowIndexPath], with: .automatic)
        }
        
        self.tableView.endUpdates()
    }
    
}


// MARK: - Приватные методы

private extension ItemsViewController {
    
    // Подготовка экрана
    func setup() {
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.navigationItem.rightBarButtonItem?.isEnabled = false
        
        self.tableView.allowsSelectionDuringEditing = true
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 44
        self.tableView.tableFooterView = UIView()
        
        // Настройка фреймворка DZNEmptyDataSet
        self.tableView.emptyDataSetSource = self
        self.tableView.emptyDataSetDelegate = self
    }
    
    /// Загрузка данных
    func loadData() {
        guard self.isUpdateAvailable else { return }
        
        self.isUpdateAvailable = false
        if self.items.isEmpty {
            self.status = .load
            self.tableView.reloadData()
        }
        
        loadItems { [weak self] success in
            if success {
                self?.status = .didLoad
                
                self?.navigationItem.rightBarButtonItem?.isEnabled = true
                self?.endLoad()
            } else {
                self?.endLoad()
            }
        }
    }
    
    /// Загрузка данных завершена
    func endLoad() {
        self.isUpdateAvailable = true
        self.tableView.reloadData()
    }
    
    /// Загрузка записей
    func loadItems(completionHandler completion: @escaping (_ success: Bool) -> Void) {
        let requestData = ItemsListRequestModel(listId: self.list.listId)
        self.apiService.itemsList(requestData: requestData) { [weak self] data in
            guard let `self` = self else { return }
            
            do {
                let items = try data()
                
                self.items = items.reversed()
                
                completion(true)
            } catch {
                if let error = error as? APIService.Error {
                    if case .failed(_, let message) = error {
                        self.status = .getError(message: message)
                    }
                } else {
                    self.status = .getError(message: error.localizedDescription)
                }
                
                if case .getError = self.status {
                    completion(false)
                }
            }
        }
    }
    
    /// Отмена загрузки
    func cancelLoad() {
        self.isUpdateAvailable = true
        self.activeRequest?.cancel()
        
        if self.status == .load {
            if self.items.isEmpty {
                self.status = .unknown
            } else {
                self.status = .didLoad
            }
        }
    }
    
    /// Удаление записи
    func deleteItem(_ item: Item, at indexPath: IndexPath) {
        let hud = self.router.presentModallyHUD(.loading)
        
        let requestData = ItemsDeleteRequestModel(itemId: item.itemId)
        self.apiService.itemsDelete(requestData: requestData) { data in
            do {
                try data()
                
                hud.contentType = .success
                
                self.items.remove(object: item)
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
                
                if self.items.isEmpty {
                    self.tableView.reloadData()
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(800)) {
                    hud.dismiss(animated: true)
                }
            } catch {
                guard let error = error as? APIService.Error, case .failed(_, let message) = error else {
                    hud.dismiss(animated: true)
                    return
                }
                
                hud.dismiss(animated: true) {
                    let alertController = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
                    
                    let okAction = UIAlertAction(title: "OK", style: .default)
                    alertController.addAction(okAction)
                    
                    self.present(alertController, animated: true)
                }
            }
        }
    }
    
}


// MARK: - UITableViewDataSource

extension ItemsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count + (self.isEditing ? 1 : 0)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.isEditing && indexPath.row == 0 {
            return tableView.dequeueReusableCell(withIdentifier: InsertItemTableViewCell.cellIdentifier, for: indexPath)
        }
        
        let item = self.items[indexPath.row - (self.isEditing ? 1 : 0)]
        let cell = tableView.dequeueReusableCell(withIdentifier: ItemTableViewCell.cellIdentifier, for: indexPath) as! ItemTableViewCell
        cell.configure(for: item)
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            let item = self.items[indexPath.row - (self.isEditing ? 1 : 0)]
            deleteItem(item, at: indexPath)
        case .insert:
            self.router.presentModallyAddItem(listId: self.list.listId, delegate: self)
            break
            
        default:
            break
        }
    }
    
}


// MARK: - UITableViewDelegate

extension ItemsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if self.isEditing && indexPath.row == 0 {
            self.tableView(tableView, commit: .insert, forRowAt: indexPath)
        } else {
            let item = self.items[indexPath.row - (self.isEditing ? 1 : 0)]
            if let cell = tableView.cellForRow(at: indexPath) as? ItemTableViewCell {
                itemTableViewCell(cell, willChange: item)
                
                // Тактильный отклик
                if #available(iOS 10.0, *) {
                    let feedbackGenerator = UIImpactFeedbackGenerator(style: .light)
                    feedbackGenerator.impactOccurred()
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        if self.isEditing && indexPath.row == 0 {
            return .insert
        }
        
        return .delete
    }
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let item = self.items[indexPath.row - (self.isEditing ? 1 : 0)]
        self.router.presentModallyEditItem(listId: self.list.listId, item: item, delegate: self)
    }
    
}


// MARK: - ItemTableViewCellDelegate

extension ItemsViewController: ItemTableViewCellDelegate {
    
    func itemTableViewCell(_ itemTableViewCell: ItemTableViewCell, willChange item: Item) {
        let hud = self.router.presentModallyHUD(.loading)
        
        let requestData = ItemsEditRequestModel(itemId: item.itemId, title: item.title, description: item.description, isActive: !item.isActive)
        self.apiService.itemsEdit(requestData: requestData) { data in
            do {
                let item = try data()
                
                hud.contentType = .success
                
                if let index = self.items.index(where: { $0 == item }) {
                    self.items[index] = item
                    
                    itemTableViewCell.item = item
                    itemTableViewCell.updateActive()
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(800)) {
                    hud.dismiss(animated: true)
                }
            } catch {
                guard let error = error as? APIService.Error, case .failed(_, let message) = error else {
                    hud.dismiss(animated: true)
                    return
                }
                
                hud.dismiss(animated: true) {
                    let alertController = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
                    
                    let okAction = UIAlertAction(title: "OK", style: .default)
                    alertController.addAction(okAction)
                    
                    self.present(alertController, animated: true)
                }
            }
        }
    }
    
}


// MARK: - ItemDetailTableViewControllerDelegate

extension ItemsViewController: ItemDetailTableViewControllerDelegate {
    
    func itemDetailTableViewController(_ itemDetailTableViewController: ItemDetailTableViewController, didCreate item: Item) {
        self.items.insert(item, at: 0)
        
        let indexPath = IndexPath(row: self.isEditing ? 1 : 0, section: 0)
        self.tableView.insertRows(at: [indexPath], with: .automatic)
        
        itemDetailTableViewController.dismiss(animated: true)
    }
    
    func itemDetailTableViewController(_ itemDetailTableViewController: ItemDetailTableViewController, didEdit item: Item) {
        if let index = self.items.index(where: { $0 == item }) {
            self.items[index] = item
            
            let indexPath = IndexPath(row: index + (self.isEditing ? 1 : 0), section: 0)
            self.tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        
        itemDetailTableViewController.dismiss(animated: true)
    }
    
    func itemDetailTableViewControllerCancel(_ itemDetailTableViewController: ItemDetailTableViewController) {
        itemDetailTableViewController.dismiss(animated: true)
    }
    
}


// MARK: - DZNEmptyDataSetSource

extension ItemsViewController: DZNEmptyDataSetSource {
    
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let text: String
        switch self.status {
        case .unknown, .load:
            return nil
        case .didLoad:
            text = "Нет записей"
        case .getError(let message):
            text = message
        }
        
        let font: UIFont = .systemFont(ofSize: 15)
        let textColor = #colorLiteral(red: 0, green: 0, blue: 0.09803921569, alpha: 0.22)
        
        let attributes: [NSAttributedStringKey : Any] = [
            .font: font,
            .foregroundColor: textColor
        ]
        let attributedString = NSAttributedString(string: text, attributes: attributes)
        return attributedString
    }
    
    func buttonTitle(forEmptyDataSet scrollView: UIScrollView!, for state: UIControlState) -> NSAttributedString! {
        let text: String
        switch self.status {
        case .unknown, .load, .didLoad:
            return nil
        case .getError:
            text = "Повторить"
        }
        
        let font: UIFont = .systemFont(ofSize: 16)
        let textColor = #colorLiteral(red: 0, green: 0.7222121358, blue: 0.9383115172, alpha: 1)
        
        let attributes: [NSAttributedStringKey : Any] = [
            .font: font,
            .foregroundColor: textColor
        ]
        let attributedString = NSAttributedString(string: text, attributes: attributes)
        return attributedString
    }
    
    func customView(forEmptyDataSet scrollView: UIScrollView!) -> UIView! {
        switch self.status {
        case .unknown, .load:
            let loadingView = LoadingView(frame: .zero)
            loadingView.font = .systemFont(ofSize: 15)
            
            return loadingView
        case .didLoad, .getError:
            return nil
        }
    }
    
}


// MARK: - DZNEmptyDataSetDelegate

extension ItemsViewController: DZNEmptyDataSetDelegate {
    
    func emptyDataSet(_ scrollView: UIScrollView!, didTap button: UIButton!) {
        loadData()
    }
    
}
