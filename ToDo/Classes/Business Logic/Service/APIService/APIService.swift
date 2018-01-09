//
//  APIService.swift
//  ToDo
//
//  Created by Илья Халяпин on 09.01.2018.
//  Copyright © 2018 Илья Халяпин. All rights reserved.
//

import Alamofire

/// Сервис API
final class APIService {
    
    // MARK: - Приватные свойства
    
    /// Сервис настроек приложения
    private let applicationSettingsService: ApplicationSettingsService
    
    
    // MARK: - Инициализация
    
    init(applicationSettingsService: ApplicationSettingsService) {
        self.applicationSettingsService = applicationSettingsService
        
        // Инициализация API
        API.initialize(host: APIConstants.host, ver: APIConstants.ver)
    }
    
}


// MARK: - Приватные свойства

private extension APIService {
    
    /// Уникальный идентификатор экземпляра приложения
    var appId: Int {
        return self.applicationSettingsService.appId
    }
    
    /// Токен
    var token: String {
        return self.applicationSettingsService.token ?? .empty
    }
    
}


// MARK: - Публичные методы

extension APIService {
    
    // MARK: - Account
    
    /// Создание учетной записи пользователя
    @discardableResult
    func accountRegistration(requestData data: AccountRegistrationRequestModel, completionHandler completion: @escaping (_ data: () throws -> Void) -> Void) -> Request {
        let request = API.Method.Account.registration(requestData: data.APIModel) { data in
            do {
                try data()
                
                DispatchQueue.main.async {
                    completion { return }
                }
            } catch let error as API.Error {
                let generatedError = APIService.generateError(with: error)
                DispatchQueue.main.async {
                    completion { throw generatedError }
                }
            } catch { }
        }
        
        return request
    }
    
    /// Авторизация пользователя в приложении
    @discardableResult
    func accountLogin(requestData data: AccountLoginRequestModel, completionHandler completion: @escaping (_ data: () throws -> LoginInfo) -> Void) -> Request {
        let request = API.Method.Account.login(requestData: data.APIModel) { data in
            do {
                let responseData = try data()
                
                let model = responseData.loginInfo
                let loginInfo = model.entity
                
                DispatchQueue.main.async {
                    completion { return loginInfo }
                }
            } catch let error as API.Error {
                let generatedError = APIService.generateError(with: error)
                DispatchQueue.main.async {
                    completion { throw generatedError }
                }
            } catch { }
        }
        
        return request
    }
    
    /// Выход из приложения
    @discardableResult
    func accountLogout(completionHandler completion: ((_ data: () throws -> Void) -> Void)? = nil) -> Request {
        let request = API.Method.Account.logout(appId: self.appId, token: self.token) { data in
            do {
                try data()
                
                DispatchQueue.main.async {
                    completion? { return }
                }
            } catch let error as API.Error {
                let generatedError = APIService.generateError(with: error)
                DispatchQueue.main.async {
                    completion? { throw generatedError }
                }
            } catch { }
        }
        
        return request
    }
    
    
    // MARK: - Colors
    
    /// Получение цветов
    @discardableResult
    func colorsList(completionHandler completion: @escaping (_ data: () throws -> [Color]) -> Void) -> Request {
        let request = API.Method.Colors.list { data in
            do {
                let responseData = try data()
                
                let model = responseData.colors
                let colors = model.map { $0.entity }
                
                DispatchQueue.main.async {
                    completion { return colors }
                }
            } catch let error as API.Error {
                let generatedError = APIService.generateError(with: error)
                DispatchQueue.main.async {
                    completion { throw generatedError }
                }
            } catch { }
        }
        
        return request
    }
    
    
    // MARK: - Icons
    
    /// Получение иконок
    @discardableResult
    func iconsList(completionHandler completion: @escaping (_ data: () throws -> [Icon]) -> Void) -> Request {
        let request = API.Method.Icons.list { data in
            do {
                let responseData = try data()
                
                let model = responseData.icons
                let icons = model.map { $0.entity }
                
                DispatchQueue.main.async {
                    completion { return icons }
                }
            } catch let error as API.Error {
                let generatedError = APIService.generateError(with: error)
                DispatchQueue.main.async {
                    completion { throw generatedError }
                }
            } catch { }
        }
        
        return request
    }
    
    
    // MARK: - Lists
    
    /// Получение списков
    @discardableResult
    func listsList(completionHandler completion: @escaping (_ data: () throws -> [List]) -> Void) -> Request {
        let request = API.Method.Lists.list(appId: self.appId, token: self.token) { data in
            do {
                let responseData = try data()
                
                let model = responseData.lists
                let lists = model.map { $0.entity }
                
                DispatchQueue.main.async {
                    completion { return lists }
                }
            } catch let error as API.Error {
                let generatedError = APIService.generateError(with: error)
                DispatchQueue.main.async {
                    completion { throw generatedError }
                }
            } catch { }
        }
        
        return request
    }
    
    /// Создание списка
    @discardableResult
    func listsCreate(requestData data: ListsCreateRequestModel, completionHandler completion: @escaping (_ data: () throws -> List) -> Void) -> Request {
        let request = API.Method.Lists.create(requestData: data.APIModel, appId: self.appId, token: self.token) { data in
            do {
                let responseData = try data()
                
                let model = responseData.list
                let list = model.entity
                
                DispatchQueue.main.async {
                    completion { return list }
                }
            } catch let error as API.Error {
                let generatedError = APIService.generateError(with: error)
                DispatchQueue.main.async {
                    completion { throw generatedError }
                }
            } catch { }
        }
        
        return request
    }
    
    /// Изменение списка
    @discardableResult
    func listsEdit(requestData data: ListsEditRequestModel, completionHandler completion: @escaping (_ data: () throws -> List) -> Void) -> Request {
        let request = API.Method.Lists.edit(requestData: data.APIModel, appId: self.appId, token: self.token) { data in
            do {
                let responseData = try data()
                
                let model = responseData.list
                let list = model.entity
                
                DispatchQueue.main.async {
                    completion { return list }
                }
            } catch let error as API.Error {
                let generatedError = APIService.generateError(with: error)
                DispatchQueue.main.async {
                    completion { throw generatedError }
                }
            } catch { }
        }
        
        return request
    }
    
    /// Удаление списка
    @discardableResult
    func listsDelete(requestData data: ListsDeleteRequestModel, completionHandler completion: @escaping (_ data: () throws -> Void) -> Void) -> Request {
        let request = API.Method.Lists.delete(requestData: data.APIModel, appId: self.appId, token: self.token) { data in
            do {
                try data()
                
                DispatchQueue.main.async {
                    completion { return }
                }
            } catch let error as API.Error {
                let generatedError = APIService.generateError(with: error)
                DispatchQueue.main.async {
                    completion { throw generatedError }
                }
            } catch { }
        }
        
        return request
    }
    
    
    // MARK: - Items
    
    /// Получение записей
    @discardableResult
    func itemsList(completionHandler completion: @escaping (_ data: () throws -> [Item]) -> Void) -> Request {
        let request = API.Method.Items.list(appId: self.appId, token: self.token) { data in
            do {
                let responseData = try data()
                
                let model = responseData.items
                let items = model.map { $0.entity }
                
                DispatchQueue.main.async {
                    completion { return items }
                }
            } catch let error as API.Error {
                let generatedError = APIService.generateError(with: error)
                DispatchQueue.main.async {
                    completion { throw generatedError }
                }
            } catch { }
        }
        
        return request
    }
    
    /// Создание списка
    @discardableResult
    func itemsCreate(requestData data: ItemsCreateRequestModel, completionHandler completion: @escaping (_ data: () throws -> Item) -> Void) -> Request {
        let request = API.Method.Items.create(requestData: data.APIModel, appId: self.appId, token: self.token) { data in
            do {
                let responseData = try data()
                
                let model = responseData.item
                let item = model.entity
                
                DispatchQueue.main.async {
                    completion { return item }
                }
            } catch let error as API.Error {
                let generatedError = APIService.generateError(with: error)
                DispatchQueue.main.async {
                    completion { throw generatedError }
                }
            } catch { }
        }
        
        return request
    }
    
    /// Изменение списка
    @discardableResult
    func itemsEdit(requestData data: ItemsEditRequestModel, completionHandler completion: @escaping (_ data: () throws -> Item) -> Void) -> Request {
        let request = API.Method.Items.edit(requestData: data.APIModel, appId: self.appId, token: self.token) { data in
            do {
                let responseData = try data()
                
                let model = responseData.item
                let item = model.entity
                
                DispatchQueue.main.async {
                    completion { return item }
                }
            } catch let error as API.Error {
                let generatedError = APIService.generateError(with: error)
                DispatchQueue.main.async {
                    completion { throw generatedError }
                }
            } catch { }
        }
        
        return request
    }
    
    /// Удаление списка
    @discardableResult
    func itemsDelete(requestData data: ItemsDeleteRequestModel, completionHandler completion: @escaping (_ data: () throws -> Void) -> Void) -> Request {
        let request = API.Method.Items.delete(requestData: data.APIModel, appId: self.appId, token: self.token) { data in
            do {
                try data()
                
                DispatchQueue.main.async {
                    completion { return }
                }
            } catch let error as API.Error {
                let generatedError = APIService.generateError(with: error)
                DispatchQueue.main.async {
                    completion { throw generatedError }
                }
            } catch { }
        }
        
        return request
    }
    
}


// MARK: - Приватные методы

private extension APIService {
    
    /// Обработка ошибки
    static func generateMessage(for error: API.Error) -> String {
        var message = "Неизвестная ошибка!"
        
        switch error {
        case .unknown(let error):
            if let error = error {
                message = error.message
            }
        case .incorrectServerAnswer(let methodTitle):
            message = "Некорректный ответ сервера на запрос \"\(methodTitle)\"!"
            
        case .otherErrorConnectionToServer(let error):
            message = "Неизвестная ошибка при подключении к серверу!" + "\n" + "\(error.localizedDescription)"
            
        case .timedOut(let _message):
            message = _message ?? "Не удалось подключиться к серверу!"
        case .cannotConnectToHost(let _message):
            message = _message ?? "Не удалось подключится к хосту!"
        case .notConnectedToInternet(let _message):
            message = _message ?? "Проблемы при подключении к интернету!"
            
        case .badRequest(let _message):
            message = _message ?? "Ошибка приложения в запросе!"
        case .unauthorized(let _message):
            message = _message ?? "Приложение не подписало вызванный метод API!"
        case .forbidden(let _message):
            message = _message ?? "Приложение не имеет доступа к запрошенному ресурсу!"
        case .notFound(let _message):
            message = _message ?? "Запрашиваемый ресурс отсутствует!"
        case .methodNotAllowed(let _message):
            message = _message ?? "Приложение использует неправильный метод HTTP!"
        case .notAcceptable(let _message):
            message = _message ?? "Запрошенная операция не может быть выполнена в силу ограничений данных!"
        case .conflict(let _message):
            message = _message ?? "Конфликт!"
        case .gone(let _message):
            message = _message ?? "Время отличается от времени сервера!"
        case .unsupportedMediaType(let _message):
            message = _message ?? "Сервер не поддерживает запрошенное приложением представление возвращаемых данных!"
        case .internalServerError(let _message):
            message = _message ?? "Ошибка сервера!"
        case .serviceUnavailable(let _message):
            message = _message ?? "В настоящее время сервер не может обслужить запрос!"
            
        default:
            break
        }
        
        return message
    }
    
    /// Создать ошибку
    static func generateError(with error: API.Error) -> Error {
        if case .cancelled = error {
            return .cancelled
        }
        
        let message = generateMessage(for: error)
        return .failed(error: error, message: message)
    }
    
}
