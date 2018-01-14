//
//  ItemDetailTableViewController.swift
//  ToDo
//
//  Created by Илья Халяпин on 10.01.2018.
//  Copyright © 2018 Илья Халяпин. All rights reserved.
//

import UIKit

final class ItemDetailTableViewController: UITableViewController {
    
    // MARK: - Outlet
    
    /// Кнопка "Готово"
    @IBOutlet
    private weak var doneBarButtonItem: UIBarButtonItem!
    
    /// Название записи
    @IBOutlet
    private weak var titleTextField: UITextField! {
        willSet {
            newValue.delegate = self
        }
    }
    /// Описание записи
    @IBOutlet
    private weak var descriptionTextView: UITextView!
    /// Галочка
    @IBOutlet
    private weak var checkmarkButton: CheckboxButton!
    
    
    // MARK: - Публичные свойства
    
    weak var delegate: ItemDetailTableViewControllerDelegate?
    
    /// Идентификатор списка
    var listId: Int!
    /// Запись
    var item: Item?
    
    
    // MARK: - Приватные свойства
    
    private lazy var router: ItemsRouter = ItemsRouter(presenter: self)
    
    /// Сервис API
    private let apiService = ServiceLayer.instance.apiService
    
}


// MARK: - Приватные свойства

private extension ItemDetailTableViewController {
    
    /// Введенное название
    var titleValue: String? {
        guard let title = self.titleTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines), !title.isEmpty else { return nil }
        return title
    }
    
    /// Введенное описание
    var descriptionValue: String? {
        guard let description = self.descriptionTextView.text?.trimmingCharacters(in: .whitespacesAndNewlines), !description.isEmpty else { return nil }
        return description
    }
    
}


// MARK: - UIViewController

extension ItemDetailTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        showData()
    }
    
}


// MARK: - UITableViewDelegate

extension ItemDetailTableViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 1 && indexPath.row == 0 {
            checkmarkButtonTapped()
        }
    }
    
}


// MARK: - Action

private extension ItemDetailTableViewController {
    
    /// Нажата кнопка "Отмена"
    @IBAction
    func cancelButtonTapped() {
        dismissKeyboard()
        self.delegate?.itemDetailTableViewControllerCancel(self)
    }
    
    /// Нажата кнопка "Готово"
    @IBAction
    func doneButtonTapped() {
        dismissKeyboard()
        
        if let item = self.item {
            editItem(item)
        } else {
            createItem()
        }
    }
    
    /// Изменено название
    @IBAction
    func titleEditingChanged() {
        self.doneBarButtonItem.isEnabled = self.titleValue != nil
    }
    
    /// Нажата галочка
    @IBAction
    func checkmarkButtonTapped() {
        self.checkmarkButton.setActive(!self.checkmarkButton.isActive, animated: true)
        
        // Тактильный отклик
        if #available(iOS 10.0, *) {
            let feedbackGenerator = UIImpactFeedbackGenerator(style: .light)
            feedbackGenerator.impactOccurred()
        }
    }
    
}


// MARK: - Приватные методы

private extension ItemDetailTableViewController {
    
    // Подготовка экрана
    func setup() {
        self.doneBarButtonItem.isEnabled = self.item != nil
        self.title = self.item == nil ? "Создание" : "Редактирование"
        
        hideKeyboardWhenTappedAround()
        
        self.titleTextField.text = nil
        self.descriptionTextView.text = nil
    }
    
    /// Отображение данных
    func showData() {
        if let item = self.item {
            self.titleTextField.text = item.title
            self.descriptionTextView.text = item.description
        }
        
        self.checkmarkButton.setActive(self.item?.isActive ?? false, animated: false)
    }
    
    /// Создание записи
    func createItem() {
        let hud = self.router.presentModallyHUD(.loading)
        
        let requestData = ItemsCreateRequestModel(listId: self.listId, title: self.titleValue ?? .empty, description: self.descriptionValue, isActive: self.checkmarkButton.isActive)
        self.apiService.itemsCreate(requestData: requestData) { data in
            do {
                let item = try data()

                hud.contentType = .success

                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(800)) {
                    hud.dismiss(animated: true) {
                        self.delegate?.itemDetailTableViewController(self, didCreate: item)
                    }
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
    
    /// Изменение записи
    func editItem(_ item: Item) {
        let hud = self.router.presentModallyHUD(.loading)
        
        let requestData = ItemsEditRequestModel(itemId: item.itemId, title: self.titleValue ?? .empty, description: self.descriptionValue, isActive: self.checkmarkButton.isActive)
        self.apiService.itemsEdit(requestData: requestData) { data in
            do {
                let item = try data()

                hud.contentType = .success

                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(800)) {
                    hud.dismiss(animated: true) {
                        self.delegate?.itemDetailTableViewController(self, didEdit: item)
                    }
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


// MARK: - UITextFieldDelegate

extension ItemDetailTableViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
