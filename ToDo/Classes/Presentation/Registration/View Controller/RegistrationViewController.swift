//
//  RegistrationViewController.swift
//  ToDo
//
//  Created by Илья Халяпин on 09.01.2018.
//  Copyright © 2018 Илья Халяпин. All rights reserved.
//

import UIKit

final class RegistrationViewController: UIViewController {
    
    // MARK: - Outlet
    
    /// Поля ввода email
    @IBOutlet
    private weak var emailTextField: UITextField! {
        willSet {
            newValue.delegate = self
        }
    }
    /// Поля ввода пароля
    @IBOutlet
    private weak var passwordTextField: UITextField! {
        willSet {
            newValue.delegate = self
        }
    }
    /// Кнопка "Регистрация"
    @IBOutlet
    private weak var registrationButton: UIButton!
    
    
    // MARK: - Приватные свойства
    
    private lazy var router: RegistrationRouter = RegistrationRouter(presenter: self)
    
    /// Сервис настроек приложения
    private let applicationSettingsService = ServiceLayer.instance.applicationSettingsService
    /// Сервис API
    private let apiService = ServiceLayer.instance.apiService
    
}


// MARK: - Приватные свойства

private extension RegistrationViewController {
    
    /// Введенный email
    var email: String? {
        guard let email = self.emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines), !email.isEmpty else { return nil }
        return email
    }
    
    /// Введенный пароль
    var password: String? {
        guard let password = self.passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines), !password.isEmpty else { return nil }
        return password
    }
    
}


// MARK: - UIViewController

extension RegistrationViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Подготовка экрана
        setup()
    }
    
}


// MARK: - Action

extension RegistrationViewController {
    
    /// Нажата кнопка "Регистрация"
    @IBAction
    func registrationButtonTapped() {
        guard let email = self.email, email.isValidEmail else {
            let alertController = UIAlertController(title: "Ошибка", message: "Введен невалидный email.", preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "OK", style: .default)
            alertController.addAction(okAction)
            
            present(alertController, animated: true)
            return
        }
        
        guard let password = self.password, password.count >= 6 else {
            let alertController = UIAlertController(title: "Ошибка", message: "Введен некорректный пароль, минимальная длина 6 символов.", preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "OK", style: .default)
            alertController.addAction(okAction)
            
            present(alertController, animated: true)
            return
        }
        
        self.applicationSettingsService.email = email
        registration(with: email, and: password)
    }
    
}


// MARK: - Приватные методы

private extension RegistrationViewController {
    
    /// Подготовка экрана
    func setup() {
        hideKeyboardWhenTappedAround()
        
        self.emailTextField.keyboardDistanceFromTextField = 140
        self.passwordTextField.keyboardDistanceFromTextField = 80
    }
    
    /// Регистрация
    func registration(with email: String, and password: String) {
        
        // Отображаем окно загрузки
        let hud = self.router.presentModallyHUD(.loading)
        
        // Отправляем запрос
        let requestData = AccountRegistrationRequestModel(email: email, password: password)
        self.apiService.accountRegistration(requestData: requestData) { data in
            do {
                try data()
                
                hud.contentType = .success
                
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(800)) {
                    hud.dismiss(animated: true) {
                        self.navigationController?.popViewController(animated: true)
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

extension RegistrationViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
