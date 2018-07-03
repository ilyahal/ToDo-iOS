//
//  ListDetailTableViewController.swift
//  ToDo
//
//  Created by Илья Халяпин on 10.01.2018.
//  Copyright © 2018 Илья Халяпин. All rights reserved.
//

import UIKit

final class ListDetailTableViewController: UITableViewController {
    
    // MARK: - Outlet
    
    /// Кнопка "Готово"
    @IBOutlet
    private weak var doneBarButtonItem: UIBarButtonItem!
    
    /// Название списка
    @IBOutlet
    private weak var titleTextField: UITextField! {
        willSet {
            newValue.delegate = self
        }
    }
    /// Описание списка
    @IBOutlet
    private weak var descriptionTextView: UITextView!
    /// Цвет списка
    @IBOutlet
    private weak var colorImageView: UIImageView!
    /// Иконка списка
    @IBOutlet
    private weak var iconImageView: UIImageView!
    
    
    // MARK: - Публичные свойства
    
    weak var delegate: ListDetailTableViewControllerDelegate?
    
    /// Цвета
    var colors: [Color]!
    /// Иконки
    var icons: [Icon]!
    
    /// Список
    var list: List?
    /// Цвет
    var color: Color!
    /// Иконка
    var icon: Icon!
    
    
    // MARK: - Приватные свойства
    
    private lazy var router: ListsRouter = ListsRouter(presenter: self)
    
    /// Сервис API
    private let apiService = ServiceLayer.instance.apiService
    
}


// MARK: - Приватные свойства

private extension ListDetailTableViewController {
    
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

extension ListDetailTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        prepareData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        showData()
    }
    
}


// MARK: - UITableViewDelegate

extension ListDetailTableViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 1 && indexPath.row == 0 {
            self.router.presentModallyColors(colors: self.colors, active: self.color, delegate: self)
        } else if indexPath.section == 1 && indexPath.row == 1 {
            self.router.presentModallyIcons(icons: self.icons, active: self.icon, delegate: self)
        }
    }
    
}


// MARK: - Action

private extension ListDetailTableViewController {
    
    /// Нажата кнопка "Отмена"
    @IBAction
    func cancelButtonTapped() {
        dismissKeyboard()
        self.delegate?.listDetailTableViewControllerCancel(self)
    }
    
    /// Нажата кнопка "Готово"
    @IBAction
    func doneButtonTapped() {
        dismissKeyboard()
        
        if let list = self.list {
            editList(list)
        } else {
            createList()
        }
    }
    
    /// Изменено название
    @IBAction
    func titleEditingChanged() {
        self.doneBarButtonItem.isEnabled = self.titleValue != nil
    }
    
}


// MARK: - Приватные методы

private extension ListDetailTableViewController {
    
    /// Подготовка экрана
    func setup() {
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.doneBarButtonItem.isEnabled = self.list != nil
        self.title = self.list == nil ? "Создание" : "Редактирование"
        
        hideKeyboardWhenTappedAround()
        
        self.titleTextField.text = nil
        self.descriptionTextView.text = nil
    }
    
    /// Подготовка данных
    func prepareData() {
        if let list = self.list {
            self.color = self.colors.first(where: { $0.colorId == list.colorId })
            self.icon = self.icons.first(where: { $0.iconId == list.iconId })
        }
        
        self.color = self.color ?? self.colors[4]
        self.icon = self.icon ?? self.icons[4]
    }
    
    /// Отображение данных
    func showData() {
        if let list = self.list {
            self.titleTextField.text = list.title
            self.descriptionTextView.text = list.description
        }
        
        let color = UIColor(red: CGFloat(self.color.red) / 255.0, green: CGFloat(self.color.green) / 255.0, blue: CGFloat(self.color.blue) / 255.0, alpha: 1)
        self.colorImageView.image = .generate(with: color, size: self.colorImageView.frame.size)
        
        let image = UIImage(named: "api_\(self.icon.name)")
        self.iconImageView.image = image
    }
    
    /// Создание списка
    func createList() {
        let hud = self.router.presentModallyHUD(.loading)
        
        let requestData = ListsCreateRequestModel(title: self.titleValue ?? .empty, description: self.descriptionValue, colorId: self.color.colorId, iconId: self.icon.iconId)
        self.apiService.listsCreate(requestData: requestData) { data in
            do {
                let list = try data()
                
                hud.contentType = .success
                
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(800)) {
                    hud.dismiss(animated: true) {
                        self.delegate?.listDetailTableViewController(self, didCreate: list)
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
    
    /// Изменение списка
    func editList(_ list: List) {
        let hud = self.router.presentModallyHUD(.loading)
        
        let requestData = ListsEditRequestModel(listId: list.listId, title: self.titleValue ?? .empty, description: self.descriptionValue, colorId: self.color.colorId, iconId: self.icon.iconId)
        self.apiService.listsEdit(requestData: requestData) { data in
            do {
                let list = try data()
                
                hud.contentType = .success
                
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(800)) {
                    hud.dismiss(animated: true) {
                        self.delegate?.listDetailTableViewController(self, didEdit: list)
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

extension ListDetailTableViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}


// MARK: - ColorsViewControllerDelegate

extension ListDetailTableViewController: ColorsViewControllerDelegate {
    
    func colorsViewController(_ colorsViewController: ColorsViewController, didSelect color: Color) {
        self.color = color
        colorsViewController.dismiss(animated: true)
    }
    
    func colorsViewControllerCancel(_ colorsViewController: ColorsViewController) {
        colorsViewController.dismiss(animated: true)
    }
    
}


// MARK: - IconsViewControllerDelegate

extension ListDetailTableViewController: IconsViewControllerDelegate {
    
    func iconsViewController(_ iconsViewController: IconsViewController, didSelect icon: Icon) {
        self.icon = icon
        iconsViewController.dismiss(animated: true)
    }
    
    func iconsViewControllerCancel(_ iconsViewController: IconsViewController) {
        iconsViewController.dismiss(animated: true)
    }
    
}
