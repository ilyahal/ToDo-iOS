//
//  API+Error.swift
//  ToDo
//
//  Created by Илья Халяпин on 09.01.2018.
//  Copyright © 2018 Илья Халяпин. All rights reserved.
//

extension API {
    
    /// Константы для обработки ошибок при работе с API
    enum Error: Swift.Error {
        
        /// Неизвестная ошибка
        case unknown(error: API.Model.ErrorModel?)
        /// Некорректный ответ сервера
        case incorrectServerAnswer(methodTitle: String)
        
        /// Другая ошибка при подключении к серверу
        case otherErrorConnectionToServer(error: Swift.Error)
        
        
        // MARK: - NSURLErrorDomain
        
        /// Отменен
        case cancelled
        /// Время на отправку запроса истекло
        case timedOut(message: String?)
        /// Не удалось подключиться к хосту
        case cannotConnectToHost(message: String?)
        /// Проблемы при подключению к интернету
        case notConnectedToInternet(message: String?)
        
        
        // MARK: - Коды ошибок HTTP
        
        /// Ошибка приложения в запросе (400)
        case badRequest(message: String?)
        /// Приложение не подписало вызванный метод API либо подпись неверна или авторизация не проведена (401)
        case unauthorized(message: String?)
        /// Приложение не имеет доступа к запрошенному ресурсу (403)
        case forbidden(message: String?)
        /// Запрашиваемый ресурс отсутствует (404)
        case notFound(message: String?)
        /// Приложение использует неправильный метод HTTP (405)
        case methodNotAllowed(message: String?)
        /// Запрошенная операция не может быть выполнена в силу ограничений данных (406)
        case notAcceptable(message: String?)
        /// Конфликт(409)
        case conflict(message: String?)
        /// Время, переданное в заголовке X-Auth-Time, отличается от времени сервера более чем на 60 секунд в меньшую или большую сторону (410)
        case gone(message: String?)
        /// Сервер не поддерживает запрошенное приложением представление возвращаемых данных (415)
        case unsupportedMediaType(message: String?)
        /// Ошибка сервера (500)
        case internalServerError(message: String?)
        /// В настоящее время сервер не может обслужить запрос (503)
        case serviceUnavailable(message: String?)
        
    }
    
}
