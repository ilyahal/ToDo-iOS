//
//  ListsViewController.swift
//  ToDo
//
//  Created by Илья Халяпин on 10.01.2018.
//  Copyright © 2018 Илья Халяпин. All rights reserved.
//

import UIKit
import Alamofire
import DZNEmptyDataSet

final class ListsViewController: UIViewController {
    
    // MARK: - Outlet
    
    @IBOutlet
    private weak var tableView: UITableView! {
        willSet {
            newValue.dataSource = self
            newValue.delegate = self
        }
    }
    
    
    // MARK: - Приватные свойства
    
    private lazy var router: ListsRouter = ListsRouter(presenter: self)
    
    /// Сервис API
    private let apiService = ServiceLayer.instance.apiService
    
    /// Списки
    private var lists: [List] = []
    /// Цвета
    private var colors: [Color] = []
    /// Иконки
    private var icons: [Icon] = []
    
    /// Активный запрос
    private weak var activeRequest: Request?
    /// Состояние
    private var status: LoadingStatus = .unknown
    /// Доступность обновления
    private var isUpdateAvailable = true
    
}


// MARK: - UIViewController

extension ListsViewController {
    
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

private extension ListsViewController {
    
    // Подготовка экрана
    func setup() {
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
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
        if self.lists.isEmpty {
            self.status = .load
            self.tableView.reloadData()
        }
        
        loadLists { [weak self] success in
            if success {
                self?.loadIcons { success in
                    if success {
                        self?.loadColors { success in
                            if success {
                                self?.status = .didLoad
                                
                                self?.navigationItem.rightBarButtonItem = self?.editButtonItem
                                self?.endLoad()
                            } else {
                                self?.endLoad()
                            }
                        }
                    } else {
                        self?.endLoad()
                    }
                }
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
    
    /// Загрузка списков
    func loadLists(completionHandler completion: @escaping (_ success: Bool) -> Void) {
        self.activeRequest = self.apiService.listsList { [weak self] data in
            guard let `self` = self else { return }
            
            do {
                let lists = try data()
                
                self.lists = lists.reversed()
                
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
    
    /// Загрузка иконок
    func loadIcons(completionHandler completion: @escaping (_ success: Bool) -> Void) {
        self.activeRequest = self.apiService.iconsList { [weak self] data in
            guard let `self` = self else { return }
            
            do {
                let icons = try data()
                
                self.icons = icons
                
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
    
    /// Загрузка цветов
    func loadColors(completionHandler completion: @escaping (_ success: Bool) -> Void) {
        self.activeRequest = self.apiService.colorsList { [weak self] data in
            guard let `self` = self else { return }
            
            do {
                let colors = try data()
                
                self.colors = colors
                
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
            if self.lists.isEmpty {
                self.status = .unknown
            } else {
                self.status = .didLoad
            }
        }
    }
    
    /// Удаление списка
    func deleteList(_ list: List, at indexPath: IndexPath) {
        let hud = self.router.presentModallyHUD(.loading)
        
        let requestData = ListsDeleteRequestModel(listId: list.listId)
        self.apiService.listsDelete(requestData: requestData) { data in
            do {
                try data()
                
                hud.contentType = .success
                
                self.lists.remove(object: list)
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
                
                if self.lists.isEmpty {
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

extension ListsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.lists.count + (self.isEditing ? 1 : 0)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.isEditing && indexPath.row == 0 {
            return tableView.dequeueReusableCell(withIdentifier: InsertListTableViewCell.cellIdentifier, for: indexPath)
        }
        
        let list = self.lists[indexPath.row - (self.isEditing ? 1 : 0)]
        let color = self.colors.first(where: { $0.colorId == list.colorId })
        let icon = self.icons.first(where: { $0.iconId == list.iconId })
        let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.cellIdentifier, for: indexPath) as! ListTableViewCell
        cell.configure(for: list, with: icon, and: color)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            let list = self.lists[indexPath.row - (self.isEditing ? 1 : 0)]
            deleteList(list, at: indexPath)
        case .insert:
            self.router.presentModallyAddList(colors: self.colors, icons: self.icons, delegate: self)
            break
        
        default:
            break
        }
    }
    
}


// MARK: - UITableViewDelegate

extension ListsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if self.isEditing && indexPath.row == 0 {
            self.tableView(tableView, commit: .insert, forRowAt: indexPath)
        } else if !self.isEditing {
            // TODO: - Отображать список
        }
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        if self.isEditing && indexPath.row == 0 {
            return .insert
        }
        
        return .delete
    }
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let list = self.lists[indexPath.row - (self.isEditing ? 1 : 0)]
        self.router.presentModallyEditList(list: list, colors: self.colors, icons: self.icons, delegate: self)
    }
    
}


// MARK: - ListDetailTableViewControllerDelegate

extension ListsViewController: ListDetailTableViewControllerDelegate {
    
    func listDetailTableViewController(_ listDetailTableViewController: ListDetailTableViewController, didCreate list: List) {
        self.lists.insert(list, at: 0)
        
        let indexPath = IndexPath(row: self.isEditing ? 1 : 0, section: 0)
        self.tableView.insertRows(at: [indexPath], with: .automatic)
        
        self.dismiss(animated: true)
    }
    
    func listDetailTableViewController(_ listDetailTableViewController: ListDetailTableViewController, didEdit list: List) {
        if let index = self.lists.index(where: { $0.listId == list.listId }) {
            self.lists[index] = list
            
            let indexPath = IndexPath(row: index + (self.isEditing ? 1 : 0), section: 0)
            self.tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        
        self.dismiss(animated: true)
    }
    
    func listDetailTableViewControllerCancel(_ listDetailTableViewController: ListDetailTableViewController) {
        self.dismiss(animated: true)
    }
    
}


// MARK: - DZNEmptyDataSetSource

extension ListsViewController: DZNEmptyDataSetSource {
    
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let text: String
        switch self.status {
        case .unknown, .load:
            return nil
        case .didLoad:
            text = "Нет списков"
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

extension ListsViewController: DZNEmptyDataSetDelegate {
    
    func emptyDataSet(_ scrollView: UIScrollView!, didTap button: UIButton!) {
        loadData()
    }
    
}
